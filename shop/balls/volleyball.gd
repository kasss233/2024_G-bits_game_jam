extends Node2D
@export var texture:Texture2D
var price = 50
var introduce = "排球\n价格：50\n简介：曾经有一群女侠用它称霸了世界"
var enum_value = GlobalVal.items.VOLLEYBALL

func change_state():
	GlobalVal.sports_list.append(GlobalVal.sports.VOLLEYBALL)
	GlobalVal.items_list.append(GlobalVal.items.VOLLEYBALL)
	pass