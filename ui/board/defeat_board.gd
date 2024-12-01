extends Control
@export var bgm:AudioStream
func _ready() -> void:
	effect()
	AudioPlayer.button_se_init(self)
	get_tree().paused=true
	process_mode=Node.PROCESS_MODE_ALWAYS
func _on_button_pressed() -> void:
	get_tree().paused=false
	GlobalVal.add_day()
	if GlobalVal.weekday == GlobalVal.week.LASTDAY:
		SceneChanger.change_scene(load("res://end/end.tscn"))
	else:
		SceneChanger.change_scene(load("res://home/home.tscn"))
		
func effect():
	GlobalVal.minus_property("stamina", 2)
	GlobalVal.minus_property("mood", 2)
	GlobalVal.minus_property("knowledge", 2)

func _process(delta):
	AudioPlayer.play_bgm(bgm)
