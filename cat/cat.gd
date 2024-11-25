extends CharacterBody2D
@onready var animation=$AnimatedSprite2D
@export var speed:int

var direction=Vector2.ZERO
func _physics_process(delta: float) -> void:
	update_velocity()
	update_animation()
	move_and_slide()
func update_velocity():
	var player_pos=GlobalVal.player["position"]
	player_pos.x-=100
	var distance=player_pos.distance_to(global_position)
	if distance<5:
		direction=Vector2.ZERO
	else:
		direction=(player_pos-global_position).normalized()
	velocity=direction*speed
func update_animation():
	if direction==Vector2.ZERO:
		animation.play("idle")
	else:
		animation.play("run")
		if direction.x<0:
			animation.flip_h=true
		else:
			animation.flip_h=false
func _init() -> void:
	speed=100
