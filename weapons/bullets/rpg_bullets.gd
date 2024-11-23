extends CharacterBody2D
@onready var area=$detectArea
@onready var sprite=$Sprite2D
var direction#外界传的
@export var speed=1000
var explosion=preload("res://weapons/effect/explosion.tscn")
func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	update_sprite()
	update_velocity()
	move_and_slide()
				
	

func _on_timer_timeout() -> void:
	queue_free()
	
func update_velocity():
	velocity=direction*speed
func update_sprite():
	sprite.rotation = direction.angle()


func _on_area_2d_body_entered(body: Node2D) -> void:
	var e=explosion.instantiate()
	get_tree().current_scene.add_child(e)
	e.global_position=global_position
	queue_free()
