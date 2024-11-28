extends Control

var on_or_off : bool = true

@onready var on_view = $on as Sprite2D
@onready var off_view = $off as Sprite2D
signal used


func _ready() -> void:
	charge()


func use():
	if on_or_off == true:
		on_or_off = false
		used.emit()
		on_view.visible = false
		off_view.visible = true

func charge():
	on_or_off = true
	on_view.visible = true
	off_view.visible = false

# func _input(event: InputEvent) -> void:
# 	if event is InputEventMouseButton:
# 		if event.is_pressed():
# 			use()