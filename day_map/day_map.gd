extends Node2D

@onready var home_button = $back_to_home
@onready var home_text = $back_to_home/Label
@onready var shop_button = $change_to_shop
@onready var shop_text = $change_to_shop/Label




# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	home_text.size = home_button.size
	shop_text.size = shop_button.size


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
