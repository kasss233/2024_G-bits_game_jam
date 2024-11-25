extends Node2D
@onready var area=$Area2D
var target: Node2D = null  # 最近的目标
var target_position:Vector2
var used:bool=false
var damage:int=1
func _ready() -> void:
	init()
	find_target()
func _physics_process(delta: float) -> void:
	if !used:
		find_target()
func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
func find_target():
	var bodies = area.get_overlapping_bodies()
	if bodies.size() > 0:
		for body in bodies:
			if !used:
				body.get_attack(damage)
		used=true
func init():
	pass
