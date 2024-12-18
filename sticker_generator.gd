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
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	pass
func _ready() -> void:
	generate()
func choose_weapon() -> PackedScene:
	if pos==POS.LEFT&&sticker_pos[pos]:
		return SPEEDER
	if pos==POS.MID&&sticker_pos[pos]:
		return DAMAGER
	if pos==POS.RIGHT&&sticker_pos[pos]:
		return HPER
	return null
func generate():
	if !choose_weapon():
		return
	var weapon = choose_weapon().instantiate()
	add_child(weapon)
	weapon.global_position = global_position
