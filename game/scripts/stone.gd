extends Sprite2D

var stone0 = preload("res://assets/riddles_asset/riddles_stone/blank_ornamnet.png")
var stone1 = preload("res://assets/riddles_asset/riddles_stone/stone_ornament1.png")
var stone2 = preload("res://assets/riddles_asset/riddles_stone/stone_ornament2.png")
var stone3 = preload("res://assets/riddles_asset/riddles_stone/stone_ornament3.png")
var stone4 = preload("res://assets/riddles_asset/riddles_stone/stone_ornament4.png")
var stone5 = preload("res://assets/riddles_asset/riddles_stone/stone_ornament5.png")

var stones = [stone0,stone1,stone2,stone3,stone4,stone5]
var texid = 0


func _on_arrow_up_pressed() -> void:
	texid+=1
	if texid>5:
		texid=0
	texture=stones[texid]


func _on_arrow_down_pressed() -> void:
	texid-=1
	if texid<0:
		texid=5
	texture=stones[texid]
