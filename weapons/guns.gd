extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var gun_sprite = $sprite/Sprite2D
@onready var bullet_pos = $sprite/Sprite2D/bullet_position
@onready var method_player = $method_player
@onready var initial_position: Vector2 = sprite.position
@export var bullet: PackedScene
@export var weapon: GlobalVal.weapons
@export var enabled: bool
var number = 30
var damage: int = 1
var constNumber: int = 0
var direction
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.AK47:
		#queue_free()
	#if !enabled:
		#queue_free()
	pass
func _physics_process(delta) -> void:
	update_data()
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
		b.damage = damage
		gun_sprite.play("shooting")
		number -= 1
	
func update_gun_rotation():
	direction = (get_global_mouse_position() - gun_sprite.global_position).normalized()
	gun_sprite.rotation = direction.angle()
	if direction.x < 0:
		gun_sprite.scale.y = -0.6 # 上下反转
	else:
		gun_sprite.scale.y = 0.6
func _init() -> void:
	match weapon:
		GlobalVal.weapons.AK47:
			damage = GlobalVal.ak47["damage"]
			number = GlobalVal.ak47["number"]
		GlobalVal.weapons.GLOCK:
			damage = GlobalVal.glock["damage"]
			number = GlobalVal.glock["number"]
		GlobalVal.weapons.RPG:
			damage = GlobalVal.rpg["damage"]
			number = GlobalVal.rpg["number"]
		GlobalVal.weapons.MP5:
			damage = GlobalVal.mp5["damage"]
			number = GlobalVal.mp5["number"]
	constNumber = number
func update_data():
	match weapon:
		GlobalVal.weapons.AK47:
			damage = GlobalVal.ak47["damage"]
			constNumber = GlobalVal.ak47["number"]
		GlobalVal.weapons.GLOCK:
			damage = GlobalVal.glock["damage"]
			constNumber = GlobalVal.glock["number"]
		GlobalVal.weapons.RPG:
			damage = GlobalVal.rpg["damage"]
			constNumber = GlobalVal.rpg["number"]
		GlobalVal.weapons.MP5:
			damage = GlobalVal.mp5["damage"]
			constNumber = GlobalVal.mp5["number"]
func reload_start():
	gun_sprite.play("reload")
func reload_end():
	number = constNumber
