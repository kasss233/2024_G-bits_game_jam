extends Node

@export var enemy_scenes: Array[PackedScene] # 敌人预制体列表
@export var spawn_points: Array[Vector2] # 敌人生成点的列表
@export var enemies_per_batch: int = 5 # 每批次生成的敌人数量
@export var total_batches: int = 10 # 总批次数量

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
		
		# 将敌人实例添加到场景中
		add_child(enemy)

		# 连接敌人销毁信号
		enemy.connect("tree_exited",Callable( self, "_on_enemy_destroyed"))
		
		# 增加活动敌人计数
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
	if active_enemies == 0 and current_batch < total_batches:
		print("Batch %d cleared!" % current_batch)
		_spawn_next_batch()
	elif active_enemies == 0 and current_batch >= total_batches:
		print("All enemies cleared!")
