extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "长矛\n售价：100\n简介：据说它的主人是个半神，带着一只叫伊卡洛斯的老鹰"
var enum_value = GlobalVal.items.SPEAR
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.SPEAR)
	GlobalVal.items_list.append(GlobalVal.items.SPEAR)
	pass