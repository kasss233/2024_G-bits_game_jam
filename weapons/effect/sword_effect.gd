extends Node2D
@onready var area=$Node2D/AnimatedSprite2D/Area2D
@onready var sprite=$Node2D/AnimatedSprite2D
@onready var transfrom=$Node2D
var target: Node2D = null  # 最近的目标
var target_position:Vector2
var used:bool=false
var direction
func _ready() -> void:
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
			body.get_attack()
		used=true
func update_sprite():
	transfrom.rotation = direction.angle()
	
