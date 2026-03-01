extends Level


@onready var foreground_1: TileMapLayer = $Foreground1
@onready var foreground_2: TileMapLayer = $Foreground2

@onready var note: Area2D = $Interactive/note
@onready var broken_button: Area2D = $Interactive/BrokenButton
@onready var working_button: Area2D = $Interactive/WorkingButton

@onready var pickup: Node2D = $CanvasLayer/pickup
@onready var ink: Area2D = $ink
@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var bad_button: Sprite2D = $CanvasLayer/Bad_button
@onready var good_button: Sprite2D = $CanvasLayer/good_button
@onready var mash_slider: Node2D = $CanvasLayer/MashSlider

var g1 = false
var g2 = false
var zag = false

func _ready() -> void:
	hide_map()


func reveal_map(ink_level: int = 0) -> void:
	foreground_1.visible = false
	foreground_1.collision_enabled = false
	foreground_2.visible = true
	foreground_2.collision_enabled = true
	

func hide_map() -> void:
	foreground_2.visible = false
	foreground_2.collision_enabled = false
	foreground_1.visible = true
	foreground_1.collision_enabled = true


func _on_note_body_entered(body: Node2D) -> void:
	pickup.show_clue2()


func _on_ink_body_entered(body: Node2D) -> void:
	
	Inventory.gain_crystal()
	ink.hide()


func _on_broken_button_body_entered(body: Node2D) -> void:
	f_button.show()
	g1=true


func _on_broken_button_body_exited(body: Node2D) -> void:
	f_button.hide()
	g1 = false
	bad_button.hide()


func _on_working_button_body_entered(body: Node2D) -> void:
	f_button.show()
	g2=true


func _on_working_button_body_exited(body: Node2D) -> void:
	f_button.hide()
	g2 = false
	good_button.hide()


func _on_zagadka_body_entered(body: Node2D) -> void:
	f_button.show()
	zag=true


func _on_zagadka_body_exited(body: Node2D) -> void:
	mash_slider.hide()
	zag= false
	f_button.hide()

func _unhandled_input(event):
	if event.is_action_pressed("press_F_to_pay_respect"):
		if g1:
			bad_button.show()
		if g2:
			good_button.show()
		if zag:
			mash_slider.show()
			

func _on_good_button_clicked() -> void:
	foreground_1.set_cell(Vector2i(20,10),0,Vector2i(0,2))
	foreground_1.set_cell(Vector2i(21,10),0,Vector2i(1,2))


func _on_mash_slider_solved() -> void:
	foreground_1.set_cell(Vector2i(23,16),0,Vector2i(2,1))
