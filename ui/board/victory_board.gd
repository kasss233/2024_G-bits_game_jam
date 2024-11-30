extends Control

func _ready() -> void:
	effect()
	AudioPlayer.button_se_init(self)
func _on_button_pressed() -> void: ## 更换场景，产生增益
	if !GlobalVal.weekday == GlobalVal.week.LASTDAY:
		GlobalVal.add_day()
		SceneChanger.change_scene(load("res://home/home.tscn"))
	else:
		SceneChanger.change_scene(load("res://end/end.tscn"))
func effect():
	GlobalVal.add_property("stamina", 1)
	GlobalVal.add_property("mood", 1)
	GlobalVal.add_property("knowledge", 1)
