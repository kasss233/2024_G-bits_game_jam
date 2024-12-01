extends Control


func _on_button_pressed() -> void:
	SceneChanger.change_scene(load("res://ui/menu/menu.tscn"))
