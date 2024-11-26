extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
@onready var initial_position=sprite.position
@onready var bullet_pos=$sprite/Sprite2D/bullet_pos
@export var bullet: PackedScene
@export var weapon:GlobalVal.weapons
@export var enabled:bool=false
@export var cd:float
@export var number:int
@export var damage:int
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.STICK:
		#queue_free()
	#if !enabled:
		#queue_free()
	pass
func _physics_process(delta) -> void:
	update_data()
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
		sprite.position.x = initial_position.x - 10
		sprite.z_index = 1;
func update_bullets():
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = bullet_pos.global_position
	b.damage = damage
func _on_timer_timeout() -> void:
	timer.wait_time = cd
	for i in number:
		update_bullets()
func _init() -> void:
	damage = GlobalVal.stick["damage"]
	number = GlobalVal.stick["number"]
	cd = GlobalVal.stick["cd"]
func update_data():
	damage = GlobalVal.stick["damage"]
	number = GlobalVal.stick["number"]
	cd = GlobalVal.stick["cd"]
