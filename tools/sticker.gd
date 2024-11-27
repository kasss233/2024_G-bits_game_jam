extends Node2D
@onready var sprite = $sprite
@onready var timer = $Timer
@onready var audio=$AudioStreamPlayer
@export var bullet: PackedScene
@export var enabled:bool=false
@export var cd:float
@export var number:int
@export var damage:int
func _process(delta: float) -> void:
	update_data()
func _ready() -> void:
	pass
func update_bullets():
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	b.damage = damage
	audio.play()
func _on_timer_timeout() -> void:
	timer.wait_time = cd
	for i in number:
		update_bullets()
func _init() -> void:
	damage = GlobalVal.stick["damage"]
	number = GlobalVal.stick["number"]
	cd = GlobalVal.stick["cd"]
func update_data():
	damage = GlobalVal.stick["damage"]
	number = GlobalVal.stick["number"]
	cd = GlobalVal.stick["cd"]
