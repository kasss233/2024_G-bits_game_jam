extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
@onready var gun_sprite = $sprite/Sprite2D
@onready var bullet_pos = $sprite/Sprite2D/bullet_position
@onready var method_player = $method_player
@export var data: WeaponDatas = null
@export var bullet: PackedScene
var initial_position: Vector2 = Vector2.ZERO
var direction
var number = 0
var reloading: bool = false
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.AK47:
		#queue_free()
	if !data.enabled:
		queue_free()
	init()
func _physics_process(delta) -> void:
	update_animation()
	update_position()
	update_gun_rotation()
func update_animation():
	if GlobalVal.player["state"] == GlobalVal.states.MOVE:
		animation.play("weapon/left_hand_running")
	elif GlobalVal.player["state"] == GlobalVal.states.IDLE:
		animation.play("weapon/RESET")
	if Input.is_action_pressed("attack"):
		if number > 0:
			method_player.play("shoot")
		else:
			method_player.play("reload")
		
func update_position():
	if GlobalVal.player["direction"].x > 0:
		sprite.position = initial_position
		sprite.z_index = 1;
	if GlobalVal.player["direction"].x < 0:
		sprite.position.x = initial_position.x - 7
		sprite.z_index = 1;
	
func update_bullets():
	if (Input.is_action_pressed("attack")):
		var b = bullet.instantiate()
		get_tree().current_scene.add_child(b)
		b.global_position = bullet_pos.global_position
		b.direction = direction
		b.damage = data.damage
		gun_sprite.play("shooting")
		number -= 1
	
func update_gun_rotation():
	direction = (get_global_mouse_position() - gun_sprite.global_position).normalized()
	gun_sprite.rotation = direction.angle()
	if direction.x < 0:
		gun_sprite.scale.y = -0.6 # 上下反转
	else:
		gun_sprite.scale.y = 0.6
func init():
	match data.weapon:
		GlobalVal.weapons.AK47:
			data.damage = GlobalVal.ak47["damage"]
			data.number = GlobalVal.ak47["number"]
		GlobalVal.weapons.GLOCK:
			data.damage = GlobalVal.glock["damage"]
			data.number = GlobalVal.glock["number"]
		GlobalVal.weapons.RPG:
			data.damage = GlobalVal.rpg["damage"]
			data.number = GlobalVal.rpg["number"]
		GlobalVal.weapons.MP5:
			data.damage = GlobalVal.mp5["damage"]
			data.number = GlobalVal.mp5["number"]
	initial_position = sprite.position
	number = data.number
func reload_start():
	gun_sprite.play("reload")
func reload_end():
	number = data.number
