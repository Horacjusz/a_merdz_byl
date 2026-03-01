extends Node2D

@onready var normal: TileMapLayer = $Normal
@onready var strange: TileMapLayer = $Strange
@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var bad_button: Sprite2D = $CanvasLayer/Bad_button
@onready var good_button: Sprite2D = $CanvasLayer/good_button

var g1 = false
var g2 = false
var another_world = false

func change_world() :
	another_world = !another_world
	
	strange.collision_enabled = !strange.collision_enabled
	strange.visible = !strange.visible
	normal.collision_enabled = !normal.collision_enabled
	normal.visible = !normal.visible


func _on_guzik_1_body_entered(body: Node2D) -> void:
	f_button.show()
	g1=true


func _on_guzik_1_body_exited(body: Node2D) -> void:
	f_button.hide()
	g1 = false
	bad_button.hide()

func _on_guzik_2_body_entered(body: Node2D) -> void:
	f_button.show()
	g2 = true

func _on_guzik_2_body_exited(body: Node2D) -> void:
	f_button.hide()
	g2 = false
	good_button.hide()

func _unhandled_input(event):
	if event.is_action_pressed("press_F_to_pay_respect"):
		if g1:
			bad_button.show()
		if g2:
			good_button.show()
