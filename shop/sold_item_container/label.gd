extends Label

func _ready():
	self.visible = false
	if GlobalVal.items_list.size() == 11:
		self.text = "恭喜，你成功把商店搬空了！"
		self.visible = true
func show_introduce(detail: String):
	self.text = detail
	self.visible = true

func hide_introduce():
	self.visible = false
