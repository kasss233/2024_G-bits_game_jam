extends Control
@onready var label=$CanvasLayer/Label
@onready var timer=$Timer
@export var time:float
signal time_out
func _ready() -> void:
	timer.wait_time=time
	timer.start()
func _physics_process(delta: float) -> void:
	label.text="下一波次时间："+var_to_str(int(timer.time_left))


func _on_timer_timeout() -> void:
	emit_signal("time_out")
	queue_free()
