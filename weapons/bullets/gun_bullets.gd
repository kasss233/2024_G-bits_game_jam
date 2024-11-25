extends CharacterBody2D
@onready var area=$detectArea
@onready var sprite=$Sprite2D
@export var speed:int=1000
@export var damage:int=1
var direction#外界传的
func _ready() -> void:
	init()
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

func init():
	pass
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.get_attack(damage)
	queue_free()
