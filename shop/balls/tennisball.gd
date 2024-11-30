extends Node2D

@export var texture:Texture2D
var price = 25
var introduce = "网球\n价格：25\n简介：在海的另一边，这种球有时会被用来作为武器使用"
var enum_value = GlobalVal.items.TENNIS
func change_state():
	GlobalVal.sports_list.append(GlobalVal.sports.TENNIS)
	GlobalVal.items_list.append(GlobalVal.items.TENNIS)
	pass