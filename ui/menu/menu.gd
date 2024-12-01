extends Control
@export var next_scene:PackedScene
@export var bgm:AudioStream

func _ready() -> void:
	AudioPlayer.button_se_init(self)

func _on_start_pressed() -> void:
	SceneChanger.change_scene(next_scene)

func _process(delta: float) -> void:
	AudioPlayer.play_bgm(bgm)

func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_thank_pressed() -> void:
	SceneChanger.change_scene(load("res://thanks/thanks.tscn"))
