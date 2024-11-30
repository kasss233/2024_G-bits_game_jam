extends  Control
@export var world:PackedScene
@onready var label=$Label2
func _on_button_pressed() -> void:
	#get_tree().change_scene_to_packed(world)
	SceneChanger.change_scene(world)
func _ready() -> void:
	if GlobalVal.early_eight:
		label.text="因为明天的早八，睡眠收到影响（梦魇更加活跃）"
