extends Node2D
@onready var label = $Label
@export var bgm:AudioStream
func _ready() -> void:
	AudioPlayer.button_se_init(self)

func _process(delta: float) -> void:

	AudioPlayer.play_bgm(bgm)

func judge():
	if GlobalVal.properties["stamina"] == 10 && GlobalVal.properties["mood"] == 10 && GlobalVal.properties["knowledge"] == 10:
		label.text = "神！"
	elif GlobalVal.properties["stamina"] == 0 && GlobalVal.properties["mood"] == 0 && GlobalVal.properties["knowledge"] == 0:
		label.text = "菜就多练"
	elif GlobalVal.properties["stamina"] == 10 && GlobalVal.properties["mood"] <= 2 && GlobalVal.properties["knowledge"] <= 2:
		label.text = "学不了一点"
	elif GlobalVal.properties["stamina"] <= 2 && GlobalVal.properties["mood"] == 10 && GlobalVal.properties["knowledge"] <= 3:
		label.text = "人生享受者"
	elif GlobalVal.properties["stamina"] <= 2 && GlobalVal.properties["mood"] <= 2 && GlobalVal.properties["knowledge"] == 10:
		label.text = "清北研究生！"
	else:
		label.text = "恭喜，过了及格线！"


func _on_button_pressed() -> void:
	SceneChanger.change_scene(load("res://ui/menu/menu.tscn"))
	# get_tree().change_scene_to_file("res://ui/menu/menu.tscn")
