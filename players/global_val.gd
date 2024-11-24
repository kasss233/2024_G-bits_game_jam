extends Node
enum states {MOVE, DEATH, IDLE}
enum weapons {HAND, STICK, AK47, GLOCK, RPG, MP5, SWORD}
enum hands {LEFT, RIGHT}
var player = {
	"direction" = Vector2.ZERO,
	"position" = Vector2.ZERO,
	"state" = states.IDLE,
	"weapon" = weapons.HAND,
	"hp" = 10,
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
	"damage" = 1
}
var enemy = {
	"hp" = 500,
	"speed" = 100,
	"damage" = 1
}
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
