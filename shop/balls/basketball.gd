extends Node2D
@export var texture:Texture2D
var price = 600
var introduce = "一颗篮球\n价格：600\n简介：球大小适中，颜色鲜艳，可以用来打篮球。"
var enum_value = GlobalVal.sports.BASKETBALL

func change_state():
	GlobalVal.sports_list.append(GlobalVal.sports.BASKETBALL)