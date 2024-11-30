extends Node2D
@onready var audio=$AudioStreamPlayer
var effect:int=1
@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	effect=randi_range(5,15)
	GlobalVal.add_day_money(effect)
	audio.play()
	visible=false
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_audio_stream_player_finished() -> void:
	queue_free()
