extends Node2D
@export var texture:Texture2D
var price = 50
var introduce = "一颗篮球\n价格：50\n简介：据说是被洛杉矶湖人队传奇24号肘击过的篮球"
var enum_value = GlobalVal.items.BASKETBALL

func change_state():
	GlobalVal.sports_list.append(GlobalVal.sports.BASKETBALL)
	GlobalVal.items_list.append(GlobalVal.items.BASKETBALL)