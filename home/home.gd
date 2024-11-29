extends Node2D

@onready var introduce = $Label

func _on_exist_pressed() -> void:
	get_tree().change_scene_to_file("res://day_map/day_map.tscn")

func _on_play_game_pressed() -> void:
	GlobalVal.add_property("mood",2)
	GlobalVal.minus_property("mobility",1)
	GlobalVal.minus_property("knowledge",1)

func _on_play_game_mouse_entered() -> void:
	introduce.text = "玩会儿游戏吧！\n心情+2\n知识-1\n行动力-1\n可能会发生别的事情"

func _on_play_game_mouse_exited() -> void:
	introduce.text = ""

func _on_sleep_mouse_entered() -> void:
	introduce.text = "我现在就要睡觉！"

func _on_sleep_mouse_exited() -> void:
	introduce.text = ""

func _on_sleep_pressed() -> void:
	get_tree().change_scene_to_file("res://ui/choose/choose_weapon.tscn")

func _on_exist_mouse_entered() -> void:
	introduce.text = "出门逛逛"

func _on_exist_mouse_exited() -> void:
	introduce.text = ""