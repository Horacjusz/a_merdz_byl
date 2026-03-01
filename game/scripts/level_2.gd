extends Level


@onready var foreground_1: TileMapLayer = $Foreground1
@onready var foreground_2: TileMapLayer = $Foreground2

@onready var note: Area2D = $Interactive/note
@onready var broken_button: Area2D = $Interactive/BrokenButton
@onready var working_button: Area2D = $Interactive/WorkingButton

@onready var pickup: Node2D = $CanvasLayer/pickup


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
	pickup.show_clue1()
