extends Level

@onready var normal: TileMapLayer = $Normal
@onready var strange: TileMapLayer = $Strange
@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var bad_button: Sprite2D = $CanvasLayer/Bad_button
@onready var good_button: Sprite2D = $CanvasLayer/good_button
@onready var wires: Node2D = $CanvasLayer/Wires
@onready var pickup: Node2D = $CanvasLayer/pickup
@onready var note_1: Area2D = $note1
@onready var note_2: Area2D = $note2
@onready var note_3: Area2D = $note3
@onready var ink: Area2D = $ink

var g1 = false
var g2 = false
var sl = false


func reveal_map(ink_level: int = 0) -> void:
	strange.collision_enabled = true
	strange.visible = true
	normal.collision_enabled = false
	normal.visible = false


func hide_map() -> void:
	strange.collision_enabled = false
	strange.visible = false
	normal.collision_enabled = true
	normal.visible = true


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
			wires.show()


func _on_good_button_clicked() -> void:
	normal.set_cell(Vector2i(11,7),0,Vector2i(0,2))
	normal.set_cell(Vector2i(12,7),0,Vector2i(1,2))


func _on_sloty_body_entered(body: Node2D) -> void:
	f_button.show()
	sl = true


func _on_sloty_body_exited(body: Node2D) -> void:
	f_button.hide()
	sl = false
	wires.hide()


func _on_note_1_body_entered(body: Node2D) -> void:
	pickup.show_clue1()


func _on_note_2_body_entered(body: Node2D) -> void:
	pickup.show_clue2()


func _on_note_3_body_entered(body: Node2D) -> void:
	pickup.show_clue3()

func _on_slots_solved() -> void:
	Inventory.gain_crystal()
	pass # Replace with function body.

func _on_ink_body_entered(body: Node2D) -> void:
	ink.hide()
