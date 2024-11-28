extends Label

@export var speed : float
var modulate_speed
@export var time : float
@onready var timer = $Timer

var started = false
func _ready() -> void:
	#if time != null:
		#timer.wait_time = time
		#modulate_speed = 1/time
		#self.start()
	if !speed:
		speed = 200
	if !time:
		time = 1
	self.visible = false
	self.global_position = Vector2(0,0)
func _process(delta : float) -> void:
	if !started:
		return 
	self.position.y = self.position.y - speed * delta
	self.modulate -= Color(0,0,0,modulate_speed*delta)


func set_message(message : String) -> void:
	text = message

func set_time(atime : float)->void:
	if !timer:
		timer = $Timer
	timer.wait_time = atime
	modulate_speed = 1/atime

func set_speed(aspeed : float)->void:
	speed = aspeed

func start()->void:
	if self.size != Vector2(1152,648):
		self.size = Vector2(1152,648)
	if !timer:
		timer = $Timer
	self.visible = true
	timer.start()
	self.started = true

func _on_timer_timeout() -> void:
	self.queue_free()
	pass # Replace with function body.

func set_color(a_color:Color):
	self.modulate = a_color
