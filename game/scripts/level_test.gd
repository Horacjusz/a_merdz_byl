extends Node2D

@onready var normal: TileMapLayer = $Normal
@onready var strange: TileMapLayer = $Strange
@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var bad_button: Sprite2D = $CanvasLayer/Bad_button
@onready var good_button: Sprite2D = $CanvasLayer/good_button
@onready var slots: Sprite2D = $CanvasLayer/slots
@onready var pickup: Node2D = $CanvasLayer/pickup
@onready var note_1: Area2D = $note1
@onready var note_2: Area2D = $note2
@onready var note_3: Area2D = $note3

var g1 = false
var g2 = false
var sl = false
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
		if sl:
			slots.show()


func _on_good_button_clicked() -> void:
	normal.set_cell(Vector2i(11,7),0,Vector2i(0,2))
	normal.set_cell(Vector2i(12,7),0,Vector2i(1,2))


func _on_sloty_body_entered(body: Node2D) -> void:
	f_button.show()
	sl = true


func _on_sloty_body_exited(body: Node2D) -> void:
	f_button.hide()
	sl = false
	slots.hide()


func _on_note_1_body_entered(body: Node2D) -> void:
	pickup.show_clue1()


func _on_note_2_body_entered(body: Node2D) -> void:
	pickup.show_clue2()


func _on_note_3_body_entered(body: Node2D) -> void:
	pickup.show_clue3()
