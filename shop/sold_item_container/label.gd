extends Label

func _ready():
	self.visible = false
	if GlobalVal.items_list.size() == 11:
		self.text = "恭喜，你成功把商店搬空了！"
		self.visible = true

func _process(delta: float) -> void:
	if self.text !="" && self.text != "恭喜，你成功把商店搬空了！":
		return
	if self.text == "恭喜，你成功把商店搬空了！":
		return
	if GlobalVal.weekday == GlobalVal.week.MONDAY:
		self.visible = true
		self.text = "商店里怎么会卖这些东西（指枪）"
func show_introduce(detail: String):
	self.text = detail
	self.visible = true

func hide_introduce():
	self.text = ""
	self.visible = false
