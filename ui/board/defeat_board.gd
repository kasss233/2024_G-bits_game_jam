extends Control

func _ready() -> void:
	AudioPlayer.button_se_init(self)
	process_mode=Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
func _on_button_pressed() -> void:
	pass # Replace with function body.
