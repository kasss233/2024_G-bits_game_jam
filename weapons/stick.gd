extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
var bullet = preload("res://weapons/bullets/bullets.tscn")
var initial_position: Vector2 = Vector2.ZERO
func _ready() -> void:
	initial_position = sprite.position
func _physics_process(delta) -> void:
	update_animation()
	update_position()
func update_animation():
	if GlobalVal.player["state"] == GlobalVal.states.MOVE:
		animation.play("weapon/left_hand_running")
	elif GlobalVal.player["state"] == GlobalVal.states.IDLE:
		animation.play("weapon/RESET")
func update_position():
	if GlobalVal.player["direction"].x > 0:
		sprite.position = initial_position
		sprite.z_index = -1;
	if GlobalVal.player["direction"].x < 0:
		sprite.position.x = initial_position.x - 7
		sprite.z_index = 1;
func update_bullets():
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	b.global_position.y -= 10
func _on_timer_timeout() -> void:
	timer.wait_time = GlobalVal.stick["cd"]
	for i in GlobalVal.stick["number"] - 1:
		update_bullets()
