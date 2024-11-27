extends CharacterBody2D
@onready var animation = $AnimatedSprite2D
@onready var Modulate = $CanvasModulate
var direction: Vector2
var bullet_position: Vector2
var used: bool = false
signal nohp
@export var speed: int = 300
@export var hp: int = 50
@export var damage: int = 1
@export var knockback_distance: int = 20
@export var drop_chance: float = 0.3 # 掉落概率 (30%)
@export var possible_drops: Array[PackedScene] = [] # 可掉落的物品预制体数组
func _ready() -> void:
	connect("nohp", Callable(self, "death_event"))
func _physics_process(delta: float) -> void:
	detect_hp()
	update_direction(delta)
	update_animation()
	move_and_slide()
	
func update_direction(delta):
	direction = (GlobalVal.player["position"] - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, 2000 * delta)
func update_animation():
	if direction.x < 0:
		animation.flip_h = true
	else:
		animation.flip_h = false
func death_event():
	collision_layer = 0
	velocity = Vector2.ZERO
	direction = Vector2.ZERO
	animation.play("death")
	drop_item()
	
func knockback(back_direction: Vector2):
	var knockback_direction = back_direction
	velocity = 0.5 * speed * back_direction.normalized()
	global_position += knockback_direction * knockback_distance

func _on_animated_sprite_2d_animation_finished() -> void:
	queue_free()
func get_attack(get_damage: int):
	hp -= get_damage
	modulate = Color(1, 0, 0, 1)
	knockback((global_position - GlobalVal.player["position"]).normalized())
	await get_tree().create_timer(0.2).timeout
	modulate = Color(1, 1, 1, 1) # 恢复为白色
func _init():
	randomize() # 初始化随机数种子
func drop_item():
	var rand = randf()
	if rand < drop_chance and possible_drops.size() > 0: # 确保有物品可以掉落
		var random_index = randi() % possible_drops.size()
		var drop = possible_drops[random_index] # 随机选择一个掉落物品
		var item_instance = drop.instantiate() # 实例化物品
		get_parent().add_child(item_instance) # 添加到场景
		item_instance.global_position = global_position # 将物品放在怪物死亡的位置
func detect_hp():
	if hp <= 0 && !used:
		emit_signal("nohp")
		used = true
