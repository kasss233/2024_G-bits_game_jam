extends Node2D
@export var texture:Texture2D
var price = 200
var introduce = "RPG\n价格:200\n介绍: RPG火箭筒是一款高科技的火箭弹射器，可用于近距离空战。据说你可以用它把直升机打下来。\n\n     “R————P————G”"
var enum_value = GlobalVal.items.RPG
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.RPG)
	GlobalVal.items_list.append(GlobalVal.items.RPG)
	pass