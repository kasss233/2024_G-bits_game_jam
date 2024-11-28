extends Node2D
@export var SPEEDER=PackedScene
@export var DAMAGER: PackedScene
@export var HPER: PackedScene
@export var pos:POS
enum POS{LEFT,MID,RIGHT}
var sticker_pos={
	POS.LEFT:GlobalVal.player["left_sticker"],
	POS.MID:GlobalVal.player["mid_sticker"],
	POS.RIGHT:GlobalVal.player["right_sticker"],
}
func _physics_process(delta: float) -> void:
	pass
func _ready() -> void:
	generate()
func choose_weapon() -> PackedScene:
	match sticker_pos[pos]:
		GlobalVal.stickers.SPEEDER:
			return SPEEDER
		GlobalVal.stickers.DAMAGER:
			return DAMAGER
		GlobalVal.stickers.HPER:
			return HPER
		_:	
			print("no sticker")
			return null
func generate():
	if !choose_weapon():
		return
	var weapon = choose_weapon().instantiate()
	add_child(weapon)
	weapon.global_position = global_position
