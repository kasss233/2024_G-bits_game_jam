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
	if texts is PackedStringArray:
		dialog_text = texts
	if texts is Array:
		dialog_text = PackedStringArray(texts)
	line_cnt = 0
	using = true
	self.visible = true
	label.text = dialog_text[line_cnt]
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
				queue_free()
				return