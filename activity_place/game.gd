extends Node2D

var dialog_tscn = preload("res://dialog_box/dialog_box.tscn")
var message_tscn = preload("res://message/message.tscn")

func _ready() -> void:
	var dialog = dialog_tscn.instantiate()
	var text = GlobalVal.random_game_dialog()
	self.add_child(dialog)
	dialog.start(text)
	dialog.tree_exited.connect(done)
func done():
	if get_tree():
		# get_tree().change_scene_to_file("res://day_map/day_map.tscn")
		SceneChanger.change_scene(load("res://day_map/day_map.tscn"))
func _exit_tree() -> void:
	GlobalVal.place_visited["game"] = true