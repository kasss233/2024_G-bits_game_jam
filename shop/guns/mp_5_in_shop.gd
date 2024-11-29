extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "mp5\n价格:500\n介绍: 一把超级牛逼的枪"

func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.MP5)
	pass