extends Control
@onready var b = $HBoxContainer/VBoxContainer/basketball
@onready var f = $HBoxContainer/VBoxContainer/football
@onready var t = $HBoxContainer/VBoxContainer/tennis
@onready var v = $HBoxContainer/VBoxContainer/volleyball
@onready var s1 = $HBoxContainer/VBoxContainer2/stick1
@onready var s2 = $HBoxContainer/VBoxContainer2/stick2
@onready var s3 = $HBoxContainer/VBoxContainer2/stick3
func _ready() -> void:
	if !GlobalVal.sports.BASKETBALL in GlobalVal.sports_list:
		b.disabled = true
	if !GlobalVal.sports.FOOTBALL in GlobalVal.sports_list:
		f.disabled = true
	if !GlobalVal.sports.TENNIS in GlobalVal.sports_list:
		t.disabled = true
	if !GlobalVal.sports.VOLLEYBALL in GlobalVal.sports_list:
		v.disabled = true
	if !GlobalVal.stickers.SPEEDER in GlobalVal.stickers_list:
		s1.disabled = true
	if !GlobalVal.stickers.DAMAGER in GlobalVal.stickers_list:
		s2.disabled = true
	if !GlobalVal.stickers.HPER in GlobalVal.stickers_list:
		s3.disabled = true
	
func _on_basketball_toggled(toggled_on: bool) -> void:
	if GlobalVal.sports.BASKETBALL in GlobalVal.sports_list:
		GlobalVal.player["basketball"] = toggled_on


func _on_football_toggled(toggled_on: bool) -> void:
	if GlobalVal.sports.FOOTBALL in GlobalVal.sports_list:
		GlobalVal.player["football"] = toggled_on


func _on_tennis_toggled(toggled_on: bool) -> void:
	if GlobalVal.sports.TENNIS in GlobalVal.sports_list:
		GlobalVal.player["tennisball"] = toggled_on


func _on_volleyball_toggled(toggled_on: bool) -> void:
	if GlobalVal.sports.VOLLEYBALL in GlobalVal.sports_list:
		GlobalVal.player["volleyball"] = toggled_on


func _on_stick_1_toggled(toggled_on: bool) -> void:
	if GlobalVal.stickers.SPEEDER in GlobalVal.stickers_list:
		GlobalVal.player["left_sticker"] = toggled_on


func _on_stick_2_toggled(toggled_on: bool) -> void:
	if GlobalVal.stickers.DAMAGER in GlobalVal.stickers_list:
		GlobalVal.player["mid_sticker"] = toggled_on


func _on_stick_3_toggled(toggled_on: bool) -> void:
	if GlobalVal.stickers.HPER in GlobalVal.stickers_list:
		GlobalVal.player["right_sticker"] = toggled_on
