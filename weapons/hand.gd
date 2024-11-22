extends Node2D

@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
@export var cd: float = 1
@export var number: int = 1
@export var hit: float = 1
var bullet = preload("res://weapons/bullets/bullets.tscn")
var initial_position: Vector2 = Vector2.ZERO
var damage: int = 1
func _ready() -> void:
	initial_position = sprite.position
func _physics_process(delta: float) -> void:
	update_animation()
	update_position()


func update_animation():
	if GlobalVal.player["state"] == GlobalVal.states.MOVE:
		animation.play("weapon/right_hand_running")
	elif GlobalVal.player["state"] == GlobalVal.states.IDLE:
		animation.play("weapon/RESET")
func update_position():
	if GlobalVal.player["direction"].x > 0:
		sprite.visible = true
		sprite.position = initial_position
		sprite.z_index = 1;
	if GlobalVal.player["direction"].x < 0:
		sprite.position.x = initial_position.x + 5
		sprite.z_index = -1;
func update_bullets():
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	b.global_position.y -= 10
func _on_timer_timeout() -> void:
	timer.wait_time = cd
	for i in number:
		update_bullets()
