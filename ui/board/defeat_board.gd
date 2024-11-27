extends Control

func _ready() -> void:
	process_mode=Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
func _on_button_pressed() -> void:
	pass # Replace with function body.
