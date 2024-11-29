extends CanvasLayer
@onready var animation=$AnimationPlayer
func _ready() -> void:
	self.hide()
func change_scene(scene:PackedScene):
	self.show()
	self.set_layer(999)
	animation.play("running")
	await  animation.animation_finished
	get_tree().change_scene_to_packed(scene)
	animation.play_backwards("running")
	await  animation.animation_finished
	self.set_layer(-999)
	self.hide()
