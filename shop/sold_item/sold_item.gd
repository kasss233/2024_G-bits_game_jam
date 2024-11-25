extends AspectRatioContainer

@export var item : Node
@export var texture : String
@export var label_price : Label

@onready var button = $Button
@onready var texture_rect = $TextureRect

var price
var sold_out = false
var introduce = "11"




signal present_introduce(detail:String)
signal hide_introduce

func _ready() -> void:
	if item!= null:
		price = item.price
		introduce = item.introduce
	if label_price!= null:
		present_introduce.connect(label_price.show_introduce)
		hide_introduce.connect(label_price.hide_introduce)
	if texture!= null:
		var image = load(texture)
		var image_texture = ImageTexture.create_from_image(image.get_image())
		image_texture.set_size_override(Vector2(64, 64))
		texture_rect.texture = image_texture
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if item!= null:
		if sold_out == false:
			sell_item()
			hide_introduce.emit()

func sell_item() -> void:
	if GlobalVal.money["day"] >= price:
		GlobalVal.minus_day_money(price)
		sold_out = true
		item.change_state();

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
