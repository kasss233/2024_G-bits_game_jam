extends VBoxContainer
@onready var label = $Label
@onready var dbutton = $damage
@onready var abutton = $ammo
@onready var cbutton = $cd
@onready var dlabel = $dlabel
@onready var alabel = $alabel
@onready var clabel = $clabel
var damage: bool = true
var ammo: bool = true
var cd: bool = true
var damage_times: int = 0
var ammo_times: int = 0
var cd_times: int = 0
var init_points: int = 0
var weapon_damage: Dictionary = {
	GlobalVal.weapons.STICK: GlobalVal.stick["damage"],
	GlobalVal.weapons.AK47: GlobalVal.ak47["damage"],
	GlobalVal.weapons.GLOCK: GlobalVal.glock["damage"],
	GlobalVal.weapons.RPG: GlobalVal.rpg["damage"],
	GlobalVal.weapons.MP5: GlobalVal.mp5["damage"],
	GlobalVal.weapons.SWORD: GlobalVal.sword["damage"],
	GlobalVal.weapons.SPEAR: GlobalVal.spear["damage"],
}
var weapon_ammo: Dictionary = {
	GlobalVal.weapons.STICK: GlobalVal.stick["number"],
	GlobalVal.weapons.AK47: GlobalVal.ak47["number"],
	GlobalVal.weapons.GLOCK: GlobalVal.glock["number"],
	GlobalVal.weapons.RPG: GlobalVal.rpg["number"],
	GlobalVal.weapons.MP5: GlobalVal.mp5["number"],
}
var weapon_cd: Dictionary = {
	GlobalVal.weapons.STICK: GlobalVal.stick["cd"],
}

var weapon_name: Dictionary = {
	GlobalVal.weapons.STICK: "STICK",
	GlobalVal.weapons.AK47: "AK47",
	GlobalVal.weapons.GLOCK: "GLOCK",
	GlobalVal.weapons.RPG: "RPG",
	GlobalVal.weapons.MP5: "MP5",
	GlobalVal.weapons.SWORD: "SWORD",
	GlobalVal.weapons.SPEAR: "SPEAR",
	GlobalVal.weapons.NULL: "NULL"
}
enum POS {LEFT, MID, RIGHT}
@export var pos: POS
var weapon_pos = {
	POS.LEFT: GlobalVal.player["left_weapon"],
	POS.MID: GlobalVal.player["weapon"],
	POS.RIGHT: GlobalVal.player["right_weapon"]
}
func _ready() -> void:
	match weapon_pos[pos]:
		GlobalVal.weapons.STICK:
			pass
		GlobalVal.weapons.AK47:
			cbutton.queue_free()
			clabel.queue_free()
			cd = false
		GlobalVal.weapons.GLOCK:
			cbutton.queue_free()
			clabel.queue_free()
			cd = false
		GlobalVal.weapons.RPG:
			abutton.queue_free()
			alabel.queue_free()
			cbutton.queue_free()
			clabel.queue_free()
			cd = false
			ammo=false
		GlobalVal.weapons.MP5:
			cbutton.queue_free()
			clabel.queue_free()
			cd = false
		GlobalVal.weapons.SWORD:
			abutton.queue_free()
			cbutton.queue_free()
			alabel.queue_free()
			clabel.queue_free()
			ammo = false
			cd = false
		GlobalVal.weapons.SPEAR:
			abutton.queue_free()
			cbutton.queue_free()
			alabel.queue_free()
			clabel.queue_free()
			ammo = false
			cd = false
		GlobalVal.weapons.NULL:
			damage=false
			ammo=false
			cd=false
			visible=false
			
func _physics_process(delta: float) -> void:
	label.text = weapon_name[weapon_pos[pos]]
	if damage:
		dlabel.text = "当前伤害：" + var_to_str(weapon_damage[weapon_pos[pos]])
	if ammo:
		alabel.text = "当前子弹数：" + var_to_str(weapon_ammo[weapon_pos[pos]])
	if cd:
		clabel.text = "当前冷却时间：" + var_to_str(weapon_cd[weapon_pos[pos]])
func _on_damage_pressed() -> void:
	if GlobalVal.player["points"] > 0:
		weapon_damage[weapon_pos[pos]] += GlobalVal.add_damage
		damage_times += 1
		GlobalVal.player["points"] -= 1
		print(weapon_name[weapon_pos[pos]], " damage:", weapon_damage[weapon_pos[pos]])
	else:
		dbutton.disabled = true
func _on_ammo_pressed() -> void:
	if GlobalVal.player["points"] > 0:
		if weapon_pos[pos]==GlobalVal.weapons.STICK:
			weapon_ammo[weapon_pos[pos]] += 1
		else:
			weapon_ammo[weapon_pos[pos]] += GlobalVal.add_ammo
		print(weapon_name[weapon_pos[pos]], " ammo:", weapon_ammo[weapon_pos[pos]])
		ammo_times += 1
		GlobalVal.player["points"] -= 1
	else:
		abutton.disabled = true
func _on_cd_pressed() -> void:
	if GlobalVal.player["points"] > 0:
		if weapon_cd[weapon_pos[pos]] > 0.2:
			weapon_cd[weapon_pos[pos]] -= GlobalVal.sub_cd
			cd_times += 1
			GlobalVal.player["points"] -= 1
			print(weapon_name[weapon_pos[pos]], " cd:", weapon_cd[weapon_pos[pos]])
		else:
			cbutton.disabled = true
			cbutton.text = "已到上限"
	else:
		cbutton.disabled = true
func _init() -> void:
	damage_times = 0
	ammo_times = 0
	cd_times = 0
	init_points = GlobalVal.player["points"]
func reset():
	GlobalVal.reset_weapons()
	weapon_damage[GlobalVal.weapons.STICK] = GlobalVal.stick["damage"]
	weapon_ammo[GlobalVal.weapons.STICK] = GlobalVal.stick["number"]
	weapon_cd[GlobalVal.weapons.STICK] = GlobalVal.stick["cd"]
	weapon_damage[GlobalVal.weapons.AK47] = GlobalVal.ak47["damage"]
	weapon_ammo[GlobalVal.weapons.AK47] = GlobalVal.ak47["number"]
	weapon_damage[GlobalVal.weapons.GLOCK] = GlobalVal.glock["damage"]
	weapon_ammo[GlobalVal.weapons.GLOCK] = GlobalVal.glock["number"]
	weapon_damage[GlobalVal.weapons.RPG] = GlobalVal.rpg["damage"]
	weapon_ammo[GlobalVal.weapons.RPG] = GlobalVal.rpg["number"]
	weapon_damage[GlobalVal.weapons.MP5] = GlobalVal.mp5["damage"]
	weapon_ammo[GlobalVal.weapons.MP5] = GlobalVal.mp5["number"]
	weapon_damage[GlobalVal.weapons.SWORD] = GlobalVal.sword["damage"]
	weapon_damage[GlobalVal.weapons.SPEAR] = GlobalVal.spear["damage"]
	if damage:
		dbutton.disabled = false
		damage_times = 0

	if ammo:
		abutton.disabled = false
		ammo_times = 0

	if cd:
		cbutton.disabled = false
		cd_times = 0

func commit_change():
	update_global_val()
func update_global_val():
	for i in range(damage_times):
		GlobalVal.upgrade_weapon(weapon_pos[pos], "damage")
	for i in range(ammo_times):
		GlobalVal.upgrade_weapon(weapon_pos[pos], "number")
	for i in range(cd_times):
		GlobalVal.upgrade_weapon(weapon_pos[pos], "cd")
