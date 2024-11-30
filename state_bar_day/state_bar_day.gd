extends Control

@onready var money_label = $money/number
@onready var body_label = $body/number
@onready var intelligence_label = $intelligence/number
@onready var mood_label = $mood/number

@export var bgm:AudioStream

var dialog_tscn = preload("res://dialog_box/dialog_box.tscn")

var mobility = []
var current_mobility = 2
var end:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:


	mobility.append($mobilty/mobility_chunck)
	mobility.append($mobilty/mobility_chunck2)
	mobility.append($mobilty/mobility_chunck3)
	if GlobalVal.weekday == GlobalVal.week.SUNDAY:
		$weekday.text = "星期天"
	if GlobalVal.weekday == GlobalVal.week.MONDAY:
		$weekday.text = "星期一"
	if GlobalVal.weekday == GlobalVal.week.TUESDAY:
		$weekday.text = "星期二"
	if GlobalVal.weekday == GlobalVal.week.WEDNESDAY:
		$weekday.text = "星期三"
	if GlobalVal.weekday == GlobalVal.week.THURSDAY:
		$weekday.text = "星期四"
	if GlobalVal.weekday == GlobalVal.week.FRIDAY:
		$weekday.text = "星期五"
	if GlobalVal.weekday == GlobalVal.week.SATURDAY:
		$weekday.text = "星期六"

	if GlobalVal.early_eight == true:
		$early_eight.text = "明天有早八"
	if GlobalVal.early_eight == false:
		$early_eight.text = "明天没早八"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	if bgm!= null:
		AudioPlayer.play_bgm(bgm)

	money_label.text = str(GlobalVal.money["day"])
	intelligence_label.text = "   " + str(GlobalVal.properties["knowledge"]) + " / 10"
	body_label.text = "   " + str(GlobalVal.properties["stamina"]) + " / 10"
	mood_label.text = "   " + str(GlobalVal.properties["mood"]) + " / 10"
	if GlobalVal.properties["mobility"] == 0:
		mobility[0].use()
		mobility[1].use()
		mobility[2].use()
	if GlobalVal.properties["mobility"] == 1:
		mobility[0].charge()
		mobility[1].use()
		mobility[2].use()
	if GlobalVal.properties["mobility"] == 2:
		mobility[0].charge()
		mobility[1].charge()
		mobility[2].use()
	if GlobalVal.properties["mobility"] == 3:
		mobility[0].charge()
		mobility[1].charge()
		mobility[2].charge()
	if GlobalVal.properties["mobility"] == 0:
		if end == true:
			return
		if end == false:
			end = true

func add_mobility(count: int) -> void:
	if count + current_mobility >= 2:
		current_mobility = 2
		for i in mobility:
			i.charge()
		return
	if count == 1:
		current_mobility += 1
		mobility[current_mobility].charge()
	if count == 2:
		current_mobility += 1
		mobility[current_mobility].charge()
		add_mobility(1)


func use_mobility() -> void:
	if current_mobility == 0:
		return
	mobility[current_mobility].use()
	current_mobility -= 1


