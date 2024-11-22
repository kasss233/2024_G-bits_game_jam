extends Node2D
var stick = preload("res://weapons/stick.tscn")
@export var effect: Dictionary = {
	"addNumber": 1,
	"mulDamage": 1.0,
	"subCd": 1,
	
}
func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalVal.stick["number"] += effect["addNumber"]
	GlobalVal.stick["damage"] *= effect["mulDamage"]
	GlobalVal.stick["cd"] -= effect["subCd"]
	queue_free()
