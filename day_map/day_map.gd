extends Node2D

@onready var home_button = $back_to_home
@onready var home_text = $back_to_home/Label
@onready var shop_button = $change_to_shop
@onready var shop_text = $change_to_shop/Label


func _ready() -> void:

	home_text.size = home_button.size
	shop_text.size = shop_button.size




func _on_change_to_shop_pressed() -> void:
	get_tree().change_scene_to_file("res://shop/shop.tscn")
