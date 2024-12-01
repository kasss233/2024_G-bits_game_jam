extends Node2D
@onready var label = $Label
@onready var mark = $mark
@export var bgm:AudioStream
func _ready() -> void:
	AudioPlayer.button_se_init(self)

func _process(delta: float) -> void:

	AudioPlayer.play_bgm(bgm)

func judge():
	mark.modulate = set_random_color()
	var tween = get_tree().create_tween()
	if GlobalVal.properties["stamina"] == 10 && GlobalVal.properties["mood"] == 10 && GlobalVal.properties["knowledge"] == 10:
		tween.tween_property(mark, "text", "100",3)
		tween.tween_property(mark, "text", "100(百分制)",0.3)
		tween.tween_property(label, "text", "神！", 0.3)
	elif GlobalVal.properties["stamina"] == 0 && GlobalVal.properties["mood"] == 0 && GlobalVal.properties["knowledge"] == 0:
		tween.tween_property(mark, "text", "0",1)
		tween.tween_property(mark, "text", "0(百分制)",0.3)
		tween.tween_property(label, "text", "菜就多练", 0.4) 
	elif GlobalVal.properties["stamina"] == 10 && GlobalVal.properties["mood"] <= 2 && GlobalVal.properties["knowledge"] <= 2:
		var tem_mark = randi() % 30 + 30
		tween.tween_property(mark, "text", str(tem_mark),2)
		tween.tween_property(mark, "text", str(tem_mark) + "(百分制)",0.3)
		tween.tween_property(label, "text", "学不了一点", 0.5) 
	elif GlobalVal.properties["stamina"] <= 2 && GlobalVal.properties["mood"] == 10 && GlobalVal.properties["knowledge"] <= 3:
		var tem_mark = randi() % 30 + 30
		tween.tween_property(mark, "text", str(tem_mark),2)
		tween.tween_property(mark, "text", str(tem_mark) + "(百分制)",0.3)
		tween.tween_property(label, "text", "人生享受者", 0.5) 
	elif GlobalVal.properties["stamina"] <= 2 && GlobalVal.properties["mood"] <= 2 && GlobalVal.properties["knowledge"] == 10:
		var tem_mark = randi() % 5 + 95
		tween.tween_property(mark, "text", str(tem_mark),2)
		tween.tween_property(mark, "text", str(tem_mark) + "(百分制)",0.5)
		tween.tween_property(label, "text", "（未来的）清北研究生！", 0.7) 
	else:
		var test_mark = randi() % 30 + 60
		tween.tween_property(mark, "text", str(test_mark),2)
		tween.tween_property(mark, "text", str(test_mark) + "(百分制)",0.5)
		tween.tween_property(label, "text", "恭喜，及格了！没挂科！", 0.7) 

func _on_button_pressed() -> void:
	SceneChanger.change_scene(load("res://ui/menu/menu.tscn"))
	# get_tree().change_scene_to_file("res://ui/menu/menu.tscn")

func set_random_color():
	var colors = [Color.ALICE_BLUE,Color.ANTIQUE_WHITE,Color.AQUA,Color.AQUAMARINE,Color.AZURE,Color.BEIGE,Color.BISQUE,Color.BLANCHED_ALMOND,Color.CORNSILK]
	return colors[randi() % colors.size()]
