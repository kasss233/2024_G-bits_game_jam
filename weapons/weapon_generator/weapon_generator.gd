extends Node2D
@export var AK47=PackedScene
@export var GLOCK: PackedScene
@export var MP5: PackedScene
@export var RPG: PackedScene
@export var SPEAR: PackedScene
@export var SWORD: PackedScene
@export var STICK: PackedScene
@export var pos:POS
enum POS{LEFT,MID,RIGHT,CAT,DOG}
var weapon_pos={
	POS.LEFT:GlobalVal.player["left_weapon"],
	POS.MID:GlobalVal.player["weapon"],
	POS.RIGHT:GlobalVal.player["right_weapon"],
	POS.CAT:GlobalVal.player["cat_weapon"],
	POS.DOG:GlobalVal.player["dog_weapon"],
}
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	pass
func _ready() -> void:
	generate()
func choose_weapon() -> PackedScene:
	match weapon_pos[pos]:
		GlobalVal.weapons.AK47:
			return AK47
		GlobalVal.weapons.GLOCK:
			return GLOCK
		GlobalVal.weapons.MP5:
			return MP5
		GlobalVal.weapons.RPG:
			return RPG
		GlobalVal.weapons.SPEAR:
			return SPEAR
		GlobalVal.weapons.SWORD:
			return SWORD
		GlobalVal.weapons.STICK:
			return STICK
		_:	
			print("no weapon")
			return null
func generate():
	if !choose_weapon():
		return
	var weapon = choose_weapon().instantiate()
	add_child(weapon)
	weapon.global_position = global_position
	weapon.weapon=weapon_pos[pos]
