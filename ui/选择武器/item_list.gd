extends ItemList
enum POS {LEFT, MID, RIGHT, CAT, DOG}
@export var label:Label
@export var pos: POS
var weapons = {
	POS.LEFT: GlobalVal.player["left_weapon"],
	POS.MID: GlobalVal.player["weapon"],
	POS.RIGHT: GlobalVal.player["right_weapon"],
	POS.CAT: GlobalVal.player["cat_weapon"],
	POS.DOG: GlobalVal.player["dog_weapon"]
}
var weapons_enable = {
	POS.LEFT: GlobalVal.player["left_weapon_enable"],
	POS.MID: GlobalVal.player["weapon_enable"],
	POS.RIGHT: GlobalVal.player["right_weapon_enable"],
	POS.CAT: GlobalVal.player["cat"],
	POS.DOG: GlobalVal.player["dog"]
}
func _ready() -> void:
	init()
func init():
	if !weapons_enable[pos]:
		queue_free()
		label.queue_free()
	if !GlobalVal.weapons.STICK in GlobalVal.weapons_list:
		set_item_disabled(1, true)
	if !GlobalVal.weapons.AK47 in GlobalVal.weapons_list:
		set_item_disabled(2, true)
	if !GlobalVal.weapons.GLOCK in GlobalVal.weapons_list:
		set_item_disabled(3, true)
	if !GlobalVal.weapons.RPG in GlobalVal.weapons_list:
		set_item_disabled(4, true)
	if !GlobalVal.weapons.MP5 in GlobalVal.weapons_list:
		set_item_disabled(5, true)
	if !GlobalVal.weapons.SWORD in GlobalVal.weapons_list:
		set_item_disabled(6, true)
	if !GlobalVal.weapons.SPEAR in GlobalVal.weapons_list:
		set_item_disabled(7, true)


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	match index:
		0:
			weapons[pos] = GlobalVal.weapons.NULL
		1:
			weapons[pos] = GlobalVal.weapons.STICK
		2:
			weapons[pos] = GlobalVal.weapons.AK47
		3:
			weapons[pos] = GlobalVal.weapons.GLOCK
		4:
			weapons[pos] = GlobalVal.weapons.RPG
		5:
			weapons[pos] = GlobalVal.weapons.MP5
		6:
			weapons[pos] = GlobalVal.weapons.SWORD
		7:
			weapons[pos] = GlobalVal.weapons.SPEAR
	update_global_val()
func update_global_val():
	match pos:
		POS.LEFT:
			GlobalVal.player["left_weapon"] = weapons[pos]
		POS.MID:
			GlobalVal.player["weapon"] = weapons[pos]
		POS.RIGHT:
			GlobalVal.player["right_weapon"] = weapons[pos]
		POS.CAT:
			GlobalVal.player["cat_weapon"] = weapons[pos]
		POS.DOG:
			GlobalVal.player["dog_weapon"] = weapons[pos]
