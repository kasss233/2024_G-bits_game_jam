extends CharacterBody2D
@onready var area=$detectArea
var target: Node2D = null  # 最近的目标
var target_position:Vector2
var direction
var damage:int=1
@export var speed=200
func _ready() -> void:
	init()
	set_random_direction()
func _physics_process(delta: float) -> void:
	find_target()
	update_direction()
	update_velocity()
	move_and_slide()
func find_target():
	var bodies = area.get_overlapping_bodies()
	if bodies.size() > 0:
		var min_distance = INF
		for body in bodies:
			var distance = global_position.distance_to(body.global_position)
			if distance < min_distance:
				min_distance = distance
				target = body as Node2D  # 选定最近的目标
				target_position=target.global_position
				
func update_direction():
	if target:
		direction = (target_position+Vector2(0,-20) - global_position).normalized()
	
func set_random_direction():
	direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	
func _on_collision_area_body_entered(body: Node2D) -> void:
	body.get_attack(damage)
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
	
func update_velocity():
	velocity=direction*speed
func init():
	pass
