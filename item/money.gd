extends Node2D
@onready var audio=$AudioStreamPlayer
@export var effect:int=1
@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	GlobalVal.add_night_money(effect)
	audio.play()
	visible=false
	


func _on_timer_timeout() -> void:
	queue_free()


func _on_audio_stream_player_finished() -> void:
	queue_free()
