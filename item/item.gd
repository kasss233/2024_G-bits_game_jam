extends Node2D
@export var effect: Dictionary = {
	"hp": 1,
}
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.data.hp+=effect["hp"]
	queue_free()
