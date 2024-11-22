extends CharacterBody2D
@onready var animation = $AnimatedSprite2D
@onready var weapon_sprite=$AnimatedSprite2D/Sprite2D
@onready var Modulate = $CanvasModulate
@export var data:EnemyData=null
var direction: Vector2
var bullet_position: Vector2
func _physics_process(delta: float) -> void:
	update_direction()
	death_event()
	move_and_collide(velocity * delta)
	
func update_direction():
	direction = (GlobalVal.player["position"] - global_position).normalized()
	velocity = direction * data.speed
	
func death_event():
	if data.hp <= 0:
		weapon_sprite.visible=false
		collision_layer = 0
		velocity = Vector2.ZERO
		direction = Vector2.ZERO
		animation.play("death")
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	body.global_position.y += 20
	data.hp -= GlobalVal.bullet["damage"] * GlobalVal.stick["damage"];
	modulate = Color(1, 0, 0, 1)
	knockback((global_position - body.global_position).normalized())
	await get_tree().create_timer(0.2).timeout
	modulate = Color(1, 1, 1, 1) # 恢复为白色
	
func knockback(direction: Vector2):
	var knockback_direction = direction
	global_position += knockback_direction * data.knockback_distance

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
