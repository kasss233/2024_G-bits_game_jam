extends Control

@onready var money_label = $money/number
@onready var body_label = $body/number
@onready var intelligence_label = $intelligence/number
@onready var mood_label = $mood/number

var mobility = []
var current_mobility = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mobility.append($mobilty/mobility_chunck)
	mobility.append($mobilty/mobility_chunck2)
	mobility.append($mobilty/mobility_chunck3)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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