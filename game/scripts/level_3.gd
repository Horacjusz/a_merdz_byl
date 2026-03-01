extends Level


@onready var foreground_1: TileMapLayer = $Foreground1
@onready var foreground_2: TileMapLayer = $Foreground2

@onready var note: Area2D = $note

@onready var pickup: Node2D = $CanvasLayer/pickup
@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var symbols: Node2D = $CanvasLayer/Symbols
@onready var Slots: Sprite2D = $CanvasLayer/slots

var zag = false
var slots = false

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

func _on_zagadka_body_entered(body: Node2D) -> void:
	f_button.show()
	zag=true

func _on_zagadka_body_exited(body: Node2D) -> void:
	symbols.hide()
	zag= false
	f_button.hide()

func _unhandled_input(event):
	if event.is_action_pressed("press_F_to_pay_respect"):
		if zag:
			symbols.show()
		if slots:
			Slots.show()


func _on_symbols_solved() -> void:
	Inventory.gain_crystal()
	pass # Replace with function body.
	#inventory add


func _on_slots_body_entered(body: Node2D) -> void:
	f_button.show()
	slots=true


func _on_slots_body_exited(body: Node2D) -> void:
	Slots.hide()
	slots=false
	f_button.hide()
