extends Node2D

signal take_a_sip(sip_value: float)

@onready var f_button: Sprite2D = $"CanvasLayer/F-button"
@onready var background_music: AudioStreamPlayer2D = $Background_music
@onready var sip_sound: AudioStreamPlayer2D = $Sip_sound

const SIP_VALUE = 0.5

func _ready() -> void:
	background_music.play()
	

func _on_range_body_entered(body: Node2D) -> void:
	print("Entered")
	f_button.show()

func _on_range_body_exited(body: Node2D) -> void:
	print("Leaved")
	f_button.hide()

func _take_a_sip() -> void :
	if f_button.visible :
		sip_sound.play()
		take_a_sip.emit(SIP_VALUE)
		f_button.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("press_F_to_pay_respect"):
		_take_a_sip()
		
