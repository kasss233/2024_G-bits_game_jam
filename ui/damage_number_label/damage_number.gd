extends Node2D

@onready var label = $Label

var velocity = Vector2(0, -100)  # 初始速度，向上抛
var gravity = 300               # 重力加速度
var lifetime = 1.0              # 持续时间（秒）

func start(str: String):
	label.text = str
	var random_color = Color(randf(), randf(), randf(), 1)  # 生成随机颜色（RGB）
	label.add_theme_color_override("font_color",random_color)   # 设置字体颜色
	await get_tree().create_timer(lifetime).timeout  # 等待 `lifetime` 秒
	queue_free()  # 删除节点

func _process(delta):
	# 更新位置
	velocity.y += gravity * delta  # 根据重力更新速度
	position += velocity * delta  # 根据速度更新位置
