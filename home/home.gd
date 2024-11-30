extends Node2D

@onready var introduce = $Label
var dialog_tscn = preload("res://dialog_box/dialog_box.tscn")
var message_tscn = preload("res://message/message.tscn")

func _on_exist_pressed() -> void:
	get_tree().change_scene_to_file("res://day_map/day_map.tscn")

func _on_play_game_pressed() -> void:
	if GlobalVal.properties["mobility"] == 0:
		var message = message_tscn.instantiate()
		message.set_message(GlobalVal.random_zero_mobility_message())	
		message.set_time(1)
		message.set_color(Color.WHITE)
		self.add_child(message)
		message.start()
		return
	GlobalVal.add_property("mood",2)
	GlobalVal.minus_property("mobility",1)
	GlobalVal.minus_property("knowledge",1)
	get_tree().change_scene_to_file("res://activity_place/game.tscn")
		

func _on_play_game_mouse_entered() -> void:
	introduce.text = "玩会儿游戏吧！\n心情+2\n知识-1\n行动力-1\n可能会发生别的事情"

func _on_play_game_mouse_exited() -> void:
	introduce.text = ""

func _on_sleep_mouse_entered() -> void:
	introduce.text = "我现在就要睡觉！"

func _on_sleep_mouse_exited() -> void:
	introduce.text = ""

func _on_sleep_pressed() -> void:
	var dialog = dialog_tscn.instantiate()
	var text = ["时间不早了","该回去睡觉了"]
	self.add_child(dialog)
	dialog.start(text)
	dialog.tree_exited.connect(sleep)

func _on_exist_mouse_entered() -> void:
	introduce.text = "出门逛逛"

func _on_exist_mouse_exited() -> void:
	introduce.text = ""

func sleep() -> void:
	if get_tree():
		get_tree().change_scene_to_file("res://ui/choose/choose_weapon.tscn")