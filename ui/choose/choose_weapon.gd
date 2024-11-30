extends  Control
@export var world:PackedScene
@onready var label=$Label2

@export var bgm:AudioStream

func _on_button_pressed() -> void:
	#get_tree().change_scene_to_packed(world)
	SceneChanger.change_scene(world)
func _ready() -> void:
	if GlobalVal.last_day_early_eight:
		label.text="因为今天的早八，你今晚感到疲惫（怪物更加活跃）"

func _process(delta):

	AudioPlayer.play_bgm(bgm)

	pass