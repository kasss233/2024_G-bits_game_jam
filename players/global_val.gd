extends Node
enum states {MOVE, DEATH, IDLE}
enum weapons {HAND, STICK, AK47, GLOCK, RPG, MP5, SWORD, SPEAR}
enum hands {LEFT, RIGHT}
var player = {
	"direction" = Vector2.ZERO,
	"position" = Vector2.ZERO,
	"state" = states.IDLE,
	"weapon" = weapons.AK47, # 确定使用武器
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
var spear = {
	"damage" = 20
}
var enemy = {
	"hp": 50,
	"speed": 100,
	"damage": 1
}
func _ready() -> void:
	pass
func _init() -> void:
	player["direction"] = Vector2.ZERO
	player["position"] = Vector2.ZERO
	player["state"] = states.IDLE
	player["weapon"] = weapons.AK47
	stick["damage"] = 1
	stick["number"] = 1
	stick["cd"] = 1
