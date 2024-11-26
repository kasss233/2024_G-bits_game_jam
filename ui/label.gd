extends Label
func _physics_process(delta: float) -> void:
	text="当前点数："+var_to_str(GlobalVal.player["points"])
