extends Node2D
@export var AK47=PackedScene
@export var GLOCK: PackedScene
@export var MP5: PackedScene
@export var RPG: PackedScene
@export var SPEAR: PackedScene
@export var SWORD: PackedScene
@export var STICK: PackedScene
func _physics_process(delta: float) -> void:
	pass
func _ready() -> void:
	generate()
func choose_weapon() -> PackedScene:
	match GlobalVal.player["weapon"]:
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
	var weapon = choose_weapon().instantiate()
	add_child(weapon)
	weapon.global_position = global_position
