extends Node2D
@export var effect:int=1
func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalVal.add_night_money(effect)
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
