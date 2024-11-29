extends Node2D
enum balls {BASKETBALL, FOOTBALL, TENNISBALL, VOLLEYBALL}
var enabled = {
	balls.BASKETBALL: GlobalVal.player["basketball"],
	balls.FOOTBALL: GlobalVal.player["football"],
	balls.TENNISBALL: GlobalVal.player["tennisball"],
	balls.VOLLEYBALL: GlobalVal.player["volleyball"]
}
@export var ball_type: balls
func _ready() -> void:
	if !enabled[ball_type]:
		queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	body.get_attack(GlobalVal.stick["damage"])
