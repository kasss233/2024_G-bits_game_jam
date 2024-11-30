extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "一把剑\n售价：100\n简介：猎魔人、亚瑟王、海拉鲁大陆的冒险者……有许多传奇用过这种武器"
var enum_value = GlobalVal.items.SWORD
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.SWORD)
	GlobalVal.items_list.append(GlobalVal.items.SWORD)
	pass