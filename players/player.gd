extends CharacterBody2D
@export var data:PlayerDatas=null
@export var animation_tree:AnimationTree##动画树
@export var sprite:Sprite2D
@onready	var animation_state=animation_tree.get("parameters/playback")
func _physics_process(delta: float) -> void:
	update_direction()
	update_state()
	update_animation()
	update_velocity(delta)
	update_global_val()
	move_and_collide(velocity*delta)
func update_direction():
	data.direction=Vector2.ZERO
	data.direction.x=Input.get_action_strength("right")-Input.get_action_strength("left")
	data.direction.y=Input.get_action_strength("down")-Input.get_action_strength("up")
	data.direction=data.direction.normalized()	
func update_state():
	if data.hp==0:
		data.state=data.States.DEATH
		return
	if data.direction==Vector2.ZERO:
		data.state=data.States.IDLE
	else: data.state=data.States.MOVE	
func update_animation():
	if data.direction.x<0:
		sprite.flip_h=true
	elif data.direction.x>0: 
		sprite.flip_h=false	
	animation_tree.set("parameters/idle/blend_position",data.direction)
	animation_tree.set("parameters/move/blend_position",data.direction)
	match data.state:
		data.States.MOVE:
			animation_state.travel("move")
		data.States.IDLE:
			animation_state.travel("idle")
		data.States.DEATH:
			animation_state.travel("death")
func update_velocity(delta):
	match data.state:
		data.States.MOVE:
			velocity=velocity.move_toward(data.direction*data.speed,data.acc*delta)
		data.States.IDLE:
			velocity=velocity.move_toward(Vector2.ZERO,data.fri*delta)
		data.States.DEATH:
			velocity=Vector2.ZERO
func update_global_val():
	GlobalVal.player["direction"]=data.direction
	GlobalVal.player["state"]=data.state
	GlobalVal.player["position"]=global_position    
