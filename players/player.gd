extends CharacterBody2D
@export var data: PlayerDatas = null
@export var animation_tree: AnimationTree ## 动画树
@export var sprite: Sprite2D
@export var defeat_board:PackedScene
@export var bgm:AudioStream
@onready var area=$Area2D
@onready var animation_state = animation_tree.get("parameters/playback")
var played:bool=false
func _ready() -> void:
	init()
	pass
func _physics_process(delta: float) -> void:
	update_direction()
	update_state()
	update_animation()
	update_velocity(delta)
	update_global_val()
	move_and_collide(velocity * delta)
func update_direction():
	data.direction = Vector2.ZERO
	data.direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	data.direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	data.direction = data.direction.normalized()
func update_state():
	if data.hp == 0:
		data.state = data.States.DEATH
		return
	if data.direction == Vector2.ZERO:
		data.state = data.States.IDLE
	else: data.state = data.States.MOVE
func update_animation():
	if data.direction.x < 0:
		sprite.flip_h = true
	elif data.direction.x > 0:
		sprite.flip_h = false
	animation_tree.set("parameters/idle/blend_position", data.direction)
	animation_tree.set("parameters/move/blend_position", data.direction)
	match data.state:
		data.States.MOVE:
			animation_state.travel("move")
		data.States.IDLE:
			animation_state.travel("idle")
		data.States.DEATH:
			animation_state.travel("death")
			death_event()
func update_velocity(delta):
	match data.state:
		data.States.MOVE:
			velocity = velocity.move_toward(data.direction * data.speed, data.acc * delta)
		data.States.IDLE:
			velocity = Vector2.ZERO
		data.States.DEATH:
			velocity = Vector2.ZERO
func update_global_val():
	GlobalVal.player["direction"] = data.direction
	GlobalVal.player["state"] = data.state
	GlobalVal.player["position"] = global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	get_attack(body)
func get_attack(body: Node2D):
	var bodies = area.get_overlapping_bodies()
	for Body in bodies:
		data.hp -= Body.damage
		modulate = Color(1, 0, 0, 1)
		await get_tree().create_timer(0.2).timeout
		modulate = Color(1, 1, 1, 1) # 恢复为白色
func init():
	data.hp = GlobalVal.player["hp"]
	data.speed = GlobalVal.player["speed"]
	data.state=data.States.IDLE
func death_event():
	if !played:
		AudioPlayer.play_sound_effect("death")
		played=true
		self.bgm = null

func _process(delta: float) -> void:
	if bgm!= null:
		AudioPlayer.play_bgm(bgm)