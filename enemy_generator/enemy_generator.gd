extends Node
@onready var canvas=$CanvasLayer
@export var enemy_scenes: Array[PackedScene] # 敌人预制体列表
@export var enemies_per_batch: int = 5 # 每批次生成的敌人数量
@export var total_batches: int = 10 # 总批次数量
@export var upgrade_board: PackedScene # 升级面板预制体
@export var spawn_rect:Array[Vector2]= [
		Vector2(-166, -80),
		Vector2(-164, -75),
		Vector2(302, -83),
		Vector2(317, 89)
	]
@export var counter:PackedScene
var spawn_points: Array[Vector2] # 敌人生成点的列表
var current_batch: int = 0 # 当前批次计数
var active_enemies: int = 0 # 当前场景中的敌人数量
var spawning: bool = true # 是否继续生成敌人
func generate_random_spawn_points():
	# 定义四个点
	var points = spawn_rect
	# 计算范围
	var min_x = min(points[0].x, points[1].x, points[2].x, points[3].x)
	var max_x = max(points[0].x, points[1].x, points[2].x, points[3].x)
	var min_y = min(points[0].y, points[1].y, points[2].y, points[3].y)
	var max_y = max(points[0].y, points[1].y, points[2].y, points[3].y)
	# 生成 50 个随机点
	for i in range(enemies_per_batch):
		var random_x = randi_range(min_x, max_x)
		var random_y = randi_range(min_y, max_y)
		spawn_points.append(Vector2(random_x, random_y))
	print("Generated spawn points: ", spawn_points)

# 开始生成敌人
func _ready():
	generate_random_spawn_points()
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
	if spawn_points.size() < enemies_per_batch:
		print("Not enough spawn points for the batch!")
		return

	# 随机打乱 spawn_points 列表
	var shuffled_spawn_points = spawn_points.duplicate()
	shuffled_spawn_points.shuffle()

	for i in range(enemies_per_batch):
		_spawn_enemy(shuffled_spawn_points[i])

# 生成单个敌人（随机类型）
func _spawn_enemy(spawn_position: Vector2):
	if enemy_scenes.size() > 0:
		# 从 enemy_scenes 中随机选择一种敌人
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
			GlobalVal.add_points()
			var c=counter.instantiate()
			get_tree().current_scene.add_child(c)
			c.connect("time_out",Callable(self,"_on_time_out"))
		else:
			print("All enemies cleared!")  # 所有敌人消灭完成

func _on_time_out():
	_spawn_next_batch()
