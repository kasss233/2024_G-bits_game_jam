extends Node

@export var enemy_scenes: Array[PackedScene] # 敌人预制体列表
@export var spawn_points: Array[Vector2] # 敌人生成点的列表
@export var enemies_per_batch: int = 5 # 每批次生成的敌人数量
@export var total_batches: int = 10 # 总批次数量
@export var upgrade_board: PackedScene # 升级面板预制体

var current_batch: int = 0 # 当前批次计数
var active_enemies: int = 0 # 当前场景中的敌人数量
var spawning: bool = true # 是否继续生成敌人

# 开始生成敌人
func _ready():
	start_spawning()

# 开始按批次生成敌人
func start_spawning():
	current_batch = 0
	spawning = true
	_spawn_next_batch()

# 停止生成敌人
func stop_spawning():
	spawning = false

# 生成一批敌人
func spawn_batch():
	for i in range(enemies_per_batch):
		_spawn_enemy()

# 生成单个敌人（随机类型）
func _spawn_enemy():
	if spawn_points.size() > 0 and enemy_scenes.size() > 0:
		# 从 `spawn_points` 中随机选择一个位置
		var spawn_position = spawn_points[randi() % spawn_points.size()]
		# 从 `enemy_scenes` 中随机选择一种敌人
		var enemy_scene = enemy_scenes[randi() % enemy_scenes.size()]
		var enemy = enemy_scene.instantiate()
		enemy.global_position = spawn_position
		add_child(enemy)
		enemy.connect("tree_exited", Callable(self, "_on_enemy_destroyed"))
		active_enemies += 1

# 当前批次生成逻辑
func _spawn_next_batch():
	if current_batch < total_batches and spawning:
		current_batch += 1
		spawn_batch()
		print("Batch %d spawned with %d enemies." % [current_batch, enemies_per_batch])
	else:
		print("All batches spawned!")

# 当敌人被销毁时触发
func _on_enemy_destroyed():
	active_enemies -= 1 # 减少活动敌人计数
	if active_enemies == 0:
		# 当前批次被清空
		print("Batch %d cleared!" % current_batch)
		
		# 如果还有批次，显示升级面板
		if current_batch < total_batches:
			GlobalVal.player["points"]+=GlobalVal.points
			await  get_tree().create_timer(2).timeout
			show_upgrade_panel()
		else:
			print("All enemies cleared!")  # 所有敌人消灭完成

# 显示升级面板
func show_upgrade_panel():
	if upgrade_board:
		var panel = upgrade_board.instantiate()
		get_tree().current_scene.add_child(panel)  # 将升级面板添加到场景根节点
		panel.global_position = get_tree().root.size / 2  # 居中显示
		panel.connect("closed", Callable(self, "_on_upgrade_panel_closed"))
		panel.process_mode=Node.PROCESS_MODE_ALWAYS
		get_tree().paused = true

# 当升级面板关闭时触发
func _on_upgrade_panel_closed():
	get_tree().paused = false
	_spawn_next_batch()
	
