extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "mp5\n价格:100\n介绍: MP5冲锋枪口径为9毫米，全枪长度680毫米，枪管长225毫米，空枪重量2.54千克，该枪拥有极高的射速，获多国的军队、保安部队、警队选择作为制式枪械使用。\n\n     未成年人请购买MP4和MP3"
var enum_value = GlobalVal.items.MP5
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.MP5)
	GlobalVal.items_list.append(GlobalVal.items.MP5)
	pass