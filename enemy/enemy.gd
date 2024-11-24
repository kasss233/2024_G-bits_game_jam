extends CharacterBody2D
@onready var animation = $AnimatedSprite2D
@onready var Modulate = $CanvasModulate
var direction: Vector2
var bullet_position: Vector2
@export var speed: int = 300
@export var hp: int = 50
@export var damage: int = 1
@export var knockback_distance: int = 20
func _ready() -> void:
	init()
func _physics_process(delta: float) -> void:
	update_direction()
	death_event()
	move_and_collide(velocity * delta)
	
func update_direction():
	direction = (GlobalVal.player["position"] - global_position).normalized()
	velocity = direction * speed
	
func death_event():
	if hp <= 0:
		collision_layer = 0
		velocity = Vector2.ZERO
		direction = Vector2.ZERO
		animation.play("death")

	
func knockback(back_direction: Vector2):
	var knockback_direction = back_direction
	global_position += knockback_direction * knockback_distance

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
func get_attack(get_damage: int):
	hp -= get_damage
	modulate = Color(1, 0, 0, 1)
	knockback((global_position - GlobalVal.player["position"]).normalized())
	await get_tree().create_timer(0.2).timeout
	modulate = Color(1, 1, 1, 1) # 恢复为白色
func init():
	speed = GlobalVal.enemy["speed"]
	hp = GlobalVal.enemy["hp"]
	damage = GlobalVal.enemy["damage"]
