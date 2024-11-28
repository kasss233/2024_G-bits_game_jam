extends Node
enum states {MOVE, DEATH, IDLE}
enum weapons {HAND, STICK, AK47, GLOCK, RPG, MP5, SWORD}
enum pets {CAT,DOG,BIRD,SNAKE,MOUSE}
enum sports {BASKETBALL,FOOTBALL,BASEBALL,TENNIS}
enum hands {LEFT, RIGHT}
var player = {
	"direction" = Vector2.ZERO,
	"position" = Vector2.ZERO,
	"state" = states.IDLE,
	"weapon" = weapons.HAND,#确定使用武器
	"hp" = 25,
	"speed" = 200,
}
var stick = {
	"damage" = 1,
	"number" = 1, # 一次性发射个数
	"cd" = 1,
}
var ak47 = {
	"damage" = 5, #
	"number" = 30 # 弹量
}
var glock = {
	"damage" = 1, #
	"number" = 15 # 弹量
}
var rpg = {
	"damage" = 5, #
	"number" = 1 # 弹量
}
var mp5 = {
	"damage" = 1, #
	"number" = 50 # 弹量
}
var sword = {
	"damage" = 10
}
var spear={
	"damage"=20
}
var enemy = {
	"hp" : 50,
	"speed" : 100,
	"damage" : 1
}

var money = {
	"day" = 1,
	"night" = 1
}

var properties = {
	"mobility" = 1,
	"stamina" = 1,
	"mood" = 1,
	"knowledge" = 1
}

var extra_prop_list = []
var weapons_list = []
var pets_list = []

func _ready() -> void:
	pass
func _init() -> void:
	player["direction"] = Vector2.ZERO
	player["position"] = Vector2.ZERO
	player["state"] = states.IDLE
	player["weapon"] = weapons.HAND
	stick["damage"] = 1
	stick["number"] = 1
	stick["cd"] = 1
	#bullet["damage"] = 1
	properties["mobility"] = 3
	properties["stamina"] = 5
	properties["mood"] = 5
	properties["knowledge"] = 5
	money["day"] = 500
	money["night"] = 1

func add_day_money(amount: int) -> void:
	money["day"] += amount

func add_night_money(amount: int) -> void:
	money["night"] += amount

func minus_day_money(amount: int) -> void:
	money["day"] -= amount

func minus_night_money(amount: int) -> void:
	money["night"] -= amount

func add_property(prop: String, value: int) -> void:
	if properties[prop]+value > 10:
		properties[prop] = 10
	else:
		properties[prop] += value

func minus_property(prop: String, value: int) -> void:
	if properties[prop]-value < 0:
		properties[prop] = 0
	else:
		properties[prop] -= value

func add_extra_prop(prop) -> void:
	extra_prop_list.append(prop)

func add_weapon(weapon) -> void:
	weapons_list.append(weapon)

func add_pet(pet) -> void:
	pets_list.append(pet)
