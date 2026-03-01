extends Node2D

@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var background_music: AudioStreamPlayer2D = $Background_music
@onready var sip_sound: AudioStreamPlayer2D = $Sip_sound

@export var sip_value = 0.3

func _ready() -> void:
	background_music.play()

func interact(player: Player) :
	_take_a_sip(player)

func _on_range_body_entered(body: Node2D) -> void:
	if body is Player :
		f_button.show()

func _on_range_body_exited(body: Node2D) -> void:
	if body is Player :
		f_button.hide()

func _take_a_sip(player) -> void :
	if f_button.visible :
		sip_sound.play()
		player.take_a_sip(sip_value)
		f_button.hide()
