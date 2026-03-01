extends Node
class_name Riddle

signal solved

var in_progress := true
var audio_player := AudioStreamPlayer.new()

func _ready() -> void:
	audio_player.set_stream(
		load("res://assets/sounds/Riddles/level-complete.mp3")
	)
	add_child(audio_player)

func solve():
	if in_progress:
		in_progress = false
		audio_player.play()
		print('solved!')
		solved.emit()
