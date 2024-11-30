extends Control
@export var next_scene:PackedScene

func _on_start_pressed() -> void:
	SceneChanger.change_scene(next_scene)


	


func _on_exit_pressed() -> void:
	get_tree().quit()
