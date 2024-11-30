extends Node2D
@export var texture:Texture2D
var price = 100
var introduce = "格洛克手枪\n价格:100\n介绍: 格洛克手枪是一款轻型的中世纪手枪，由德国制造，采用了德国式的枪管，枪身由一根长柄的钢管和一根短柄的钢管组成，枪身上有一道深色的缝，使得手感更为精致。"
var enum_value = GlobalVal.weapons.GLOCK
func change_state():
	GlobalVal.weapons_list.append(GlobalVal.weapons.GLOCK)
	pass