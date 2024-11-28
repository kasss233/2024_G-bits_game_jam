extends Node2D

@onready var sprite = $sprite
@onready var initial_position = sprite.position
@onready var area=$sprite/sprite/Area2D
@onready var audio=$AudioStreamPlayer
@export var damage: int = 1
@export var enabled: bool = false
@export var weapon:GlobalVal.weapons
var direction = Vector2.ZERO
var is_attacking = false

func _ready() -> void:
	#if not enabled:
		#queue_free()
	pass
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	update_data()
	update_position()
	update_rotation()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("attack") and not is_attacking:
		attack()
		audio.play()

func attack():
	is_attacking = true
	area.monitoring=true
	direction = (get_global_mouse_position() - sprite.global_position).normalized()
	var target_position = initial_position + direction * 50 # 矛突刺距离为 50 像素
	var tween = create_tween()
	tween.tween_property(sprite, "position", target_position, 0.1) # 矛突刺时间为 0.1 秒
	tween.tween_property(sprite, "position", initial_position, 0.1) # 返回时间为 0.1 秒
	tween.connect("finished", Callable(self, "_on_attack_finished"))
func _on_attack_finished():
	is_attacking = false
	area.monitoring=false

func update_rotation():
	direction = (get_global_mouse_position() - sprite.global_position).normalized()
	sprite.rotation = direction.angle()
	#if direction.x < 0:
		#sprite.scale.y = -1 # 上下反转
	#else:
		#sprite.scale.y = 1

func _init() -> void:
	damage = GlobalVal.spear["damage"]
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.get_attack(damage)

func update_position():
	if GlobalVal.player["direction"].x > 0:
		sprite.position = initial_position
	elif GlobalVal.player["direction"].x < 0:
		sprite.position.x = initial_position.x - 5
func update_data():
	damage = GlobalVal.spear["damage"]
