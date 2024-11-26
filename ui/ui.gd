extends Control

@export var player: CharacterBody2D
@export var enemy_generator:Node2D
@onready var hp_sprite = $hps/hp_frame/hp_value
@onready var label = $labels/VSplitContainer/Label
@onready var mlabel=$labels/VSplitContainer/money
var countdown_time: float = 15 * 60 # 倒计时总时间（15分钟，单位为秒）

# 更新血条和倒计时
func _physics_process(delta: float) -> void:
	_update_health_bar()
	_update_countdown(delta)

# 更新血条显示
func _update_health_bar():
	if player.data.hp > 0:
		var health_ratio = clamp(float(player.data.hp) / GlobalVal.player["hp"], 0.0, 1.0)
		hp_sprite.scale.x = health_ratio
	elif player.data.hp<=0:
		hp_sprite.visible=false
		_game_over()

# 更新倒计时
func _update_countdown(delta: float):
	if countdown_time > 0:
		countdown_time -= delta # 每帧减少时间
		var minutes = int(countdown_time) / 60
		var seconds = int(countdown_time) % 60
		label.text = "剩余时间：%02d:%02d" % [minutes, seconds] # 格式化为 mm:ss
	else:
		label.text = "Time's up!"
		_game_over() # 倒计时结束后调用游戏结束逻辑（可选）
	mlabel.text="金币："+var_to_str(GlobalVal.money["night"])
# 游戏结束逻辑（可选）
func _game_over():
	pass
