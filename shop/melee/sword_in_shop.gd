extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "一把剑\n售价：100\n简介：据说是从石头缝里蹦出来的"
var enum_value = GlobalVal.weapons.SWORD
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.SWORD)
	pass