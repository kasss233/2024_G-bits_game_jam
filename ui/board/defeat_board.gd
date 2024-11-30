extends Control

func _ready() -> void:
	effect()
	AudioPlayer.button_se_init(self)
func _on_button_pressed() -> void:
	if !GlobalVal.weekday == GlobalVal.week.LASTDAY:
		GlobalVal.add_day()
		SceneChanger.change_scene(load("res://home/home.tscn"))
	else:
		SceneChanger.change_scene(load("res://end/end.tscn"))
func effect():
	GlobalVal.minus_property("stamina", 2)
	GlobalVal.minus_property("mood", 2)
	GlobalVal.minus_property("knowledge", 2)
