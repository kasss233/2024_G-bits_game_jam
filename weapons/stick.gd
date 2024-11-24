extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
@export var data: WeaponDatas = null
@export var bullet: PackedScene
var initial_position: Vector2 = Vector2.ZERO
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.STICK:
		#queue_free()
	if !data.enabled:
		queue_free()
	initial_position = sprite.position
	init()
func _physics_process(delta) -> void:
	update_animation()
	update_position()
func update_animation():
	if GlobalVal.player["state"] == GlobalVal.states.MOVE:
		animation.play("weapon/right_hand_running")
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
	b.damage = data.damage
func _on_timer_timeout() -> void:
	timer.wait_time = data.cd
	for i in data.number:
		update_bullets()
func init() -> void:
	data.damage = GlobalVal.stick["damage"]
	data.number = GlobalVal.stick["number"]
	data.cd = GlobalVal.stick["cd"]
	initial_position = sprite.position
	timer.wait_time = data.cd
