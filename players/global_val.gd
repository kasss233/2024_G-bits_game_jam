extends Node
enum states {MOVE, DEATH, IDLE}
enum weapons {HAND, STICK}
enum hands {LEFT, RIGHT}
var player = {
	"direction" = Vector2.ZERO,
	"position" = Vector2.ZERO,
	"state" = states.IDLE,
}
var stick = {
	"damage" = 1,
	"number" = 1,
	"cd" = 1,
	"hand" = hands.LEFT
}
var bullet = {
	"damage" = 1
}
func _ready() -> void:
	pass
func _init() -> void:
	player["direction"] = Vector2.ZERO
	player["position"] = Vector2.ZERO
	player["state"] = states.IDLE
	player["left_weapon"] = weapons.HAND
	player["right_weapon"] = weapons.HAND
	stick["damage"] = 1
	stick["number"] = 1
	stick["cd"] = 1
	bullet["damage"] = 1
