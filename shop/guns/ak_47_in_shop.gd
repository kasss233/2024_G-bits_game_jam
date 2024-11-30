extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "AK47\n价格:500\n介绍: 美国一支由美国人制造的轻型冲锋枪，由AK字母组成，是美国历史上最著名的枪支之一。"
var enum_value = GlobalVal.weapons.AK47
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.AK47)
	pass