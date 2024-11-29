extends Control
@export var left:VBoxContainer
@export var mid:VBoxContainer
@export var right:VBoxContainer
signal closed
func _ready() -> void:
	AudioPlayer.button_se_init(self)
func _on_exit_pressed() -> void:
	left.commit_change()
	mid.commit_change()
	right.commit_change()
	emit_signal("closed")
	queue_free()


func _on_reset_pressed() -> void:
	left.reset()
	mid.reset()
	right.reset()
