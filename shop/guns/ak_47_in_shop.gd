extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "AK47\n价格:500\n介绍:原本的售价为2700，最近在打折。有五个悍匪钟爱这把AK。"
var enum_value = GlobalVal.weapons.AK47
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.AK47)
	pass
