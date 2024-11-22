extends Node2D
var stick=preload("res://weapons/stick.tscn")
@export var effect:Dictionary={
	"number":1,
	"damage":1,
	"cd":1,
	
}
func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalVal.stick["number"]+=1
	queue_free()
