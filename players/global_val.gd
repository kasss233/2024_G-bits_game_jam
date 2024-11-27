extends Node
enum states {MOVE, DEATH, IDLE}
enum weapons {STICK, AK47, GLOCK, RPG, MP5, SWORD, SPEAR, NULL}
enum stickers {SPEEDER, DAMAGER, HPER, NULL}
enum hands {LEFT, RIGHT}
const add_damage: int = 1 ## 武器伤害增加
const add_ammo: int = 5 ## 武器弹量增加
const sub_cd: float = 0.1 ## 武器冷却时间减少
const add_hp: int = 1 ## 血量增加
const add_speed: int = 10 ## 速度增加
var points: int = 0
var player = {
	"direction" = Vector2.ZERO, # 非可修改属性
	"position" = Vector2.ZERO, # 非可修改属性
	"state" = states.IDLE, # 非可修改属性
	"hp" = 10, # 血量
	"speed" = 150, # 速度
	"left_weapon" = weapons.SPEAR, # 左边武器栏
	"weapon" = weapons.RPG, # 中间武器栏
	"right_weapon" = weapons.AK47, # 右边武器栏
	"left_sticker" = stickers.NULL, # 左边饰品栏
	"mid_sticker" = stickers.DAMAGER, # 中间饰品栏
	"right_sticker" = stickers.HPER, # 右边饰品栏
	"cat" = true, # 是否拥有猫咪
	"cat_weapon" = weapons.MP5, # 猫咪武器
	"dog" = true, # 是否拥有狗狗
	"dog_weapon" = weapons.AK47, # 狗狗武器
	"points" = 0, # 武器升级点数
}
var stick = {
	"damage" = 1, # 伤害
	"number" = 1, # 一次性发射个数
	"cd" = 1, # 冷却时间
}
var ak47 = {
	"damage" = 3, # 伤害
	"number" = 30 # 弹量
}
var glock = {
	"damage" = 1, # 伤害
	"number" = 15 # 弹量
}
var rpg = {
	"damage" = 7, # 伤害
	"number" = 1 # 弹量
}
var mp5 = {
	"damage" = 2, # 伤害
	"number" = 50 # 弹量
}
var sword = {
	"damage" = 4 # 伤害
}
var spear = {
	"damage" = 4 # 伤害
}
var enemy = { ## 此处不生效，敌人属性在场景设置
	"hp": 30,
	"speed": 100,
	"damage": 1
}
var money = {
	"day" = 1,
	"night" = 0
}

var properties = {
	"mobility" = 1,
	"stamina" = 1,
	"mood" = 1,
	"knowledge" = 1
}

var extra_prop = []
var weapons_list = []
var pets = []

func _ready() -> void:
	pass
func _init() -> void:
	#bullet["damage"] = 1
	properties["mobility"] = 3
	properties["stamina"] = 5
	properties["mood"] = 5
	properties["knowledge"] = 5
	money["day"] = 500
	money["night"] = 1

func add_day_money(amount: int) -> void:
	money["day"] += amount

func add_night_money(amount: int) -> void:
	money["night"] += amount

func minus_day_money(amount: int) -> void:
	money["day"] -= amount

func minus_night_money(amount: int) -> void:
	money["night"] -= amount

func add_property(prop: String, value: int) -> void:
	if properties[prop] + value > 10:
		properties[prop] = 10
	else:
		properties[prop] += value

func minus_property(prop: String, value: int) -> void:
	if properties[prop] - value < 0:
		properties[prop] = 0
	else:
		properties[prop] -= value

func add_extra_prop(prop) -> void:
	extra_prop.append(prop)

func add_weapon(weapon) -> void:
	weapons_list.append(weapon)

func add_pet(pet) -> void:
	pets.append(pet)

func upgrade_weapon(weapon: weapons, attr: String) -> void:
	match weapon:
		weapons.STICK:
			match attr:
				"damage":
					stick["damage"] += add_damage
				"number":
					stick["number"] += add_damage
				"cd":
					stick["cd"] -= sub_cd
		weapons.AK47:
			match attr:
				"damage":
					ak47["damage"] += add_damage
				"number":
					ak47["number"] += add_ammo
		weapons.GLOCK:
			match attr:
				"damage":
					glock["damage"] += add_damage
				"number":
					glock["number"] += add_ammo
		weapons.RPG:
			match attr:
				"damage":
					rpg["damage"] += add_damage
				"number":
					rpg["number"] += add_ammo
		weapons.MP5:
			match attr:
				"damage":
					mp5["damage"] += add_damage
				"number":
					mp5["number"] += add_ammo
		weapons.SWORD:
			match attr:
				"damage":
					sword["damage"] += add_damage
		weapons.SPEAR:
			match attr:
				"damage":
					spear["damage"] += add_damage
		# TODO: 添加其他武器
func add_points():
	player["points"] += 1
	points += 1
func reset_weapons():
	stick["damage"] = 1
	stick["number"] = 1
	stick["cd"] = 1
	ak47["damage"] = 3
	ak47["number"] = 30
	glock["damage"] = 1
	glock["number"] = 15
	rpg["damage"] = 7
	rpg["number"] = 1
	mp5["damage"] = 2
	mp5["number"] = 50
	sword["damage"] = 4
	spear["damage"] = 4
	player["points"] = points
# TODO: 添加其他武器
