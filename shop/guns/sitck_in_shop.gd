extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "魔杖\n价格:100\n介绍: 阿瓦达啃大瓜！"
var enum_value = GlobalVal.weapons.STICK
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.STICK)
	pass