extends Label

func _ready():
	self.visible = false

func show_introduce(detail: String):
	self.text = detail
	self.visible = true

func hide_introduce():
	self.visible = false
