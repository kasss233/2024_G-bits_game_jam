extends AspectRatioContainer

@export var item : Node
@export var texture : Texture2D
@export var size_x : float
@export var size_y : float
@export var label_price : Label

@onready var button = $Button
@onready var texture_rect = $TextureRect

var message = preload("res://message/message.tscn")

var price
var sold_out = false
var introduce = "11"

signal sold(item:Node)
signal money_not_enough
signal present_introduce(detail:String)
signal hide_introduce

func _ready() -> void:
	if size_x && size_y:
		self.size = Vector2(size_x, size_y)
	else:
		self.size = Vector2(64, 64)
	if item!= null:
		if item.enum_value in GlobalVal.weapons_list:
			self.queue_free()
		if item.enum_value in GlobalVal.sports_list:
			self.queue_free()

		price = item.price
		introduce = item.introduce
		if item.texture!= null:
			texture = item.texture
	if label_price!= null:
		present_introduce.connect(label_price.show_introduce)
		hide_introduce.connect(label_price.hide_introduce)
	if texture!= null:
		texture_rect.texture = texture
		# print(Vector2(64.0/texture.get_height(),64.0/texture.get_width()))
		# self.scale = Vector2(64.0/texture.get_height(),64.0/texture.get_width())
		# self.scale = Vector2(64.0/texture.get_width(),64.0/texture.get_height())
		# print(texture.get_width())
		# print(texture.get_height())
		# print(self.scale)
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if item!= null:
		if sold_out == false:
			sell_item()

func sell_item() -> void:
	if GlobalVal.money["day"] >= price:
		GlobalVal.minus_day_money(price)
		sold.emit(item)
		_on_sold_out()
		item.change_state();
		hide_introduce.emit()
		$TextureRect.visible = false
		$Button.visible = false
		return
	if GlobalVal.money["day"] < price:
		money_not_enough.emit()

func _on_button_mouse_entered() -> void:
	if button.has_focus() == false:
		button.grab_focus()
	if sold_out == false:
		present_introduce.emit(introduce)


func _on_button_mouse_exited() -> void:
	if button.has_focus() == true:
		button.release_focus()
	if sold_out == false:
		hide_introduce.emit()

func _on_sold_out() -> void:
	sold_out = true
	var node = message.instantiate()
	node.set_time(1)
	node.set_message("购买成功~")
	node.set_color(Color.BLACK)
	get_parent().add_child(node)
	node.global_position = Vector2(0,0)
	node.start()

func _on_money_not_enough() -> void:
	var node = message.instantiate()
	node.set_time(1)
	node.set_color(Color.BLACK)
	node.set_message(GlobalVal.random_no_money_message())
	get_parent().add_child(node)
	node.global_position = Vector2(0,0)
	node.start()
