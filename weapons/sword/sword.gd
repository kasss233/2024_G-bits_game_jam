extends Node2D
@onready var animation = $AnimationPlayer
@onready var sprite = $sprite
@onready var timer = $Timer
@onready var sword_sprite = $sprite/Sprite2D
@onready var bullet_pos = $sprite/Sprite2D/bullet_position
@onready var initial_position=sprite.position
@export var cd:float=0.1
@export var damage:int=1
@export var enabled:bool=false
var weapon:GlobalVal.weapons
var direction = Vector2.ZERO
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.AK47:
		#queue_free()
	#if !enabled:
		#queue_free()
	pass
func _physics_process(delta) -> void:
	update_data()
	update_position()
	update_rotation()
	pass

	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		if direction.x >= 0:
			animation.play("sword_attack_right")
		if direction.x < 0:
			animation.play("sword_attack_left")
	
func update_rotation():
	direction = (get_global_mouse_position() - sword_sprite.global_position).normalized()
	sword_sprite.rotation = direction.angle()
	if direction.x<0:
		sword_sprite.rotation += PI # 朝左时旋转 180 度，调整方向
	
func _init() -> void:
	damage = GlobalVal.sword["damage"]

func _on_area_2d_body_entered(body: Node2D) -> void:
	body.get_attack(damage)
	
func update_position():
	if GlobalVal.player["direction"].x > 0:
		sprite.position.x = initial_position.x+5
	if GlobalVal.player["direction"].x < 0:
		sprite.position.x = initial_position.x - 5
func update_data():
	damage=GlobalVal.sword["damage"]
