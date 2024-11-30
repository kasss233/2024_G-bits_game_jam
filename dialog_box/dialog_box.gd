extends Control

@export var dialog_text:PackedStringArray = []
@onready var label = $Label
var line_cnt = 0

var using: bool = false

func _ready() -> void:
	self.visible = false
	using = false
	pass
func start(texts) -> void:
	var tween = get_tree().create_tween()
	self.visible = true
	self.global_position = Vector2(0, 200)
	tween.tween_property(self, "global_position", Vector2(0, 0), 0.3)
	tween.tween_callback(true_start.bind(texts))

func true_start(texts)->void:
	using = true
	if texts is PackedStringArray:
		dialog_text = texts
	if texts is Array:
		dialog_text = PackedStringArray(texts)
	line_cnt = 0
	$Label.text = dialog_text[line_cnt]
	line_cnt += 1


func _input(event: InputEvent) -> void:
	if !using:
		return
	if event is InputEventMouse:
		if event.is_pressed():
			if line_cnt < dialog_text.size():
				label.text = dialog_text[line_cnt]
				line_cnt += 1
				return
			if line_cnt >= dialog_text.size():
				true_end()
				using = false
				return

func true_end()->void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", Vector2(0, 200), 0.3)
	tween.tween_callback(self.queue_free)
