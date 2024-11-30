extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "AK47\n价格:100\n介绍:枪身短小、射程较短，适合较近距离的战斗。该枪采用导气式自动原理，回转式闭锁枪机，7.62毫米口径，发射7.62×39毫米M1943型中间型威力枪弹，容量30发子弹的弧形弹匣供弹\n\n     原价2700——是的，我们给了相当大的优惠"
var enum_value = GlobalVal.items.AK47
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.AK47)
	GlobalVal.items_list.append(GlobalVal.items.AK47)
	pass