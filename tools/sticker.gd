extends Node2D
@onready var sprite = $sprite
@onready var timer = $Timer
@export var bullet: PackedScene
@export var enabled:bool=false
@export var cd:float
@export var number:int
@export var damage:int
func _ready() -> void:
	#if GlobalVal.player["weapon"]!=GlobalVal.weapons.STICK:
		#queue_free()
	if !enabled:
		queue_free()

func update_bullets():
	var b = bullet.instantiate()
	get_tree().current_scene.add_child(b)
	b.global_position = global_position
	b.damage = damage
func _on_timer_timeout() -> void:
	timer.wait_time = cd
	for i in number:
		update_bullets()
func _init() -> void:
	damage = GlobalVal.stick["damage"]
	number = GlobalVal.stick["number"]
	cd = GlobalVal.stick["cd"]
