extends Node2D

@onready var introduce = $Label
var dialog_tscn = preload("res://dialog_box/dialog_box.tscn")
var message_tscn = preload("res://message/message.tscn")

func _on_exist_pressed() -> void:
	# get_tree().change_scene_to_file("res://day_map/day_map.tscn")
	SceneChanger.change_scene(load("res://day_map/day_map.tscn"))

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
	# get_tree().change_scene_to_file("res://activity_place/game.tscn")
	SceneChanger.change_scene(load("res://activity_place/game.tscn"))
		

func _on_play_game_mouse_entered() -> void:
	if $play_game.has_focus() == false:
		$play_game.grab_focus()
	introduce.text = "玩会儿游戏吧！\n心情+2\n知识-1\n行动力-1\n可能会发生别的事情"

func _on_play_game_mouse_exited() -> void:
	if $play_game.has_focus() == true:
		$play_game.release_focus()
	introduce.text = ""

func _on_sleep_mouse_entered() -> void:
	if $sleep.has_focus() == false:
		$sleep.grab_focus()
	introduce.text = "我现在就要睡觉！"

func _on_sleep_mouse_exited() -> void:
	if $sleep.has_focus() == true:
		$sleep.release_focus()
	introduce.text = ""

func _on_sleep_pressed() -> void:
	var dialog = dialog_tscn.instantiate()
	var text = ["时间不早了","该回去睡觉了"]
	self.add_child(dialog)
	dialog.start(text)
	dialog.tree_exited.connect(sleep)

func _on_exist_mouse_entered() -> void:
	introduce.text = "出门逛逛"
	if $exist.has_focus() == false:
		$exist.grab_focus()

func _on_exist_mouse_exited() -> void:
	if $exist.has_focus() == true:
		$exist.release_focus()
	introduce.text = ""

func sleep() -> void:
	if GlobalVal.weekday == GlobalVal.week.MONDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 8#5
		GlobalVal.enemy_gen["total_batch"] = 3#3
		GlobalVal.enemy_gen["time_gap"] = 2#3
		GlobalVal.enemy_gen["enemy_per_time"] = 1#1
	elif GlobalVal.weekday == GlobalVal.week.TUESDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 20
		GlobalVal.enemy_gen["total_batch"] = 5
		GlobalVal.enemy_gen["time_gap"] = 2
		GlobalVal.enemy_gen["enemy_per_time"] = 3
	elif GlobalVal.weekday == GlobalVal.week.WEDNESDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 50
		GlobalVal.enemy_gen["total_batch"] = 5
		GlobalVal.enemy_gen["time_gap"] = 1
		GlobalVal.enemy_gen["enemy_per_time"] = 2
	elif GlobalVal.weekday == GlobalVal.week.THURSDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 60
		GlobalVal.enemy_gen["total_batch"] = 5
		GlobalVal.enemy_gen["time_gap"] = 1
		GlobalVal.enemy_gen["enemy_per_time"] = 3
	elif GlobalVal.weekday == GlobalVal.week.FRIDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 80
		GlobalVal.enemy_gen["total_batch"] = 6
		GlobalVal.enemy_gen["time_gap"] = 1
		GlobalVal.enemy_gen["enemy_per_time"] = 3
	elif GlobalVal.weekday == GlobalVal.week.SATURDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 100
		GlobalVal.enemy_gen["total_batch"] = 7
		GlobalVal.enemy_gen["time_gap"] = 1
		GlobalVal.enemy_gen["enemy_per_time"] = 4
	elif GlobalVal.weekday == GlobalVal.week.SUNDAY:
		GlobalVal.enemy_gen["enemy_per_batch"] = 200
		GlobalVal.enemy_gen["total_batch"] = 8
		GlobalVal.enemy_gen["time_gap"] = 1
		GlobalVal.enemy_gen["enemy_per_time"] = 5
	if GlobalVal.last_day_early_eight:
		GlobalVal.enemy_gen["total_batch"] +=1
		GlobalVal.enemy_gen["enemy_per_time"]+=1
	if get_tree():
		SceneChanger.change_scene(load("res://ui/choose/choose_weapon.tscn"))

func _ready() -> void:
	if GlobalVal.new_day:
		$sleep.visible = false
		$exist.visible = false
		$play_game.visible = false
		$Label.visible = false
		$state_bar_day.visible = false

	if GlobalVal.new_day:
		GlobalVal.new_day = false
		var dialog = dialog_tscn.instantiate()
		var text = ["新的一天开始了","“昨天做了个好长的梦”","你想"]
		if GlobalVal.last_day_early_eight:
			text.append("今天有早八")
		else:
			text.append("今天没有早八")
		self.add_child(dialog)
		dialog.start(text)
		dialog.tree_exited.connect(start_day)
		
func start_day() -> void:
	if get_tree():
		$sleep.visible = true
		$exist.visible = true
		$play_game.visible = true
		$Label.visible = true
		$state_bar_day.visible = true
