extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
@onready var gun_sprite=$sprite/Sprite2D
@onready var bullet_pos=$sprite/Sprite2D/bullet_position
@export var data:WeaponDatas=null
var bullet = preload("res://weapons/bullets/gun_bullets.tscn")
var initial_position: Vector2 = Vector2.ZERO
var direction
var number=0
var reloading:bool=false
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.AK47:
		#queue_free()
	if !data.enabled:
		queue_free()
	init_val()
func _physics_process(delta) -> void:
	update_animation()
	update_position()
	update_gun_rotation()
func update_animation():
	if GlobalVal.player["state"] == GlobalVal.states.MOVE:
		animation.play("weapon/left_hand_running")
	elif GlobalVal.player["state"] == GlobalVal.states.IDLE:
		animation.play("weapon/RESET")
func update_position():
	if GlobalVal.player["direction"].x > 0:
		sprite.position = initial_position
		sprite.z_index = 1;
	if GlobalVal.player["direction"].x < 0:
		sprite.position.x = initial_position.x - 7
		sprite.z_index = 1;
	
		
func update_bullets():
	if(Input.is_action_pressed("attack")):
		var b = bullet.instantiate()
		get_tree().current_scene.add_child(b)
		b.global_position = bullet_pos.global_position
		b.direction=direction
		gun_sprite.play("shooting")
		number-=1
func _on_timer_timeout() -> void:
	if number > 0 && !reloading:
		update_bullets()
	elif number <= 0 and !reloading:  # 防止重复进入换弹状态
		reloading = true
		gun_sprite.play("reload")
	
func update_gun_rotation():
	direction = (get_global_mouse_position() - gun_sprite.global_position).normalized()
	gun_sprite.rotation = direction.angle()
	if direction.x<0:
		gun_sprite.scale.y = -0.6  # 上下反转
	else:
		gun_sprite.scale.y = 0.6
func init_val():
	initial_position = sprite.position
	timer.wait_time=data.cd
	number=data.number


func _on_sprite_2d_animation_finished() -> void:
	if gun_sprite.animation == "reload":  # 确保是换弹动画完成
		number = data.number
		reloading = false
