extends Node2D

func _on_exsit_pressed() -> void:
	# get_tree().change_scene_to_file("res://day_map/day_map.tscn")
	SceneChanger.change_scene(load("res://day_map/day_map.tscn"))



func _on_exsit_mouse_exited() -> void:
	if $exsit.has_focus() == true:
		$exsit.release_focus()

func _on_exsit_mouse_entered() -> void:
	if $exsit.has_focus() == false:
		$exsit.grab_focus()