extends Control


func _on_stick_pressed() -> void:
	GlobalVal.player["weapon"]=GlobalVal.weapons.STICK


func _on_ak_47_pressed() -> void:
	GlobalVal.player["weapon"]=GlobalVal.weapons.AK47


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://world/world.tscn")
