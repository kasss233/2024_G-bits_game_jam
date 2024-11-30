extends Node2D
@export var texture:Texture2D
var price = 500
var introduce = "RPG\n价格:500\n介绍: RPG火箭筒是一款高科技的火箭弹射器，可用于近距离空战。"
var enum_value = GlobalVal.weapons.RPG
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.RPG)
	pass