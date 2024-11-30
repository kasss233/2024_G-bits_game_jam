extends Node2D
@export var texture:Texture2D
var price = 50
var introduce = "足球\n价格：50元\n简介：据说曾经有一个戴眼镜的小学生用这玩意儿把直升机打下来了"
var enum_value = GlobalVal.items.FOOTBALL

func change_state():
	GlobalVal.sports_list.append(GlobalVal.sports.FOOTBALL)
	GlobalVal.items_list.append(GlobalVal.items.FOOTBALL)