extends Node2D
@export var texture:Texture2D
var price = 0
var introduce = "格洛克手枪\n价格:0\n介绍: 免费的手枪，每个回合都能用"
var enum_value = GlobalVal.items.GLOCK
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.GLOCK)
	GlobalVal.items_list.append(GlobalVal.items.GLOCK)
	pass