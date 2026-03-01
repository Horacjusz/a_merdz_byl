extends Node2D

@onready var clue_1: Sprite2D = $clue1
@onready var clue_2: Sprite2D = $clue2
@onready var clue_3: Sprite2D = $clue3
@onready var timer: Timer = $Timer

func show_clue1():
	clue_1.show()
	timer.start(3)

func show_clue2():
	clue_2.show()
	timer.start(3)

func show_clue3():
	clue_3.show()
	timer.start(3)



func _on_timer_timeout() -> void:
	clue_1.hide()
	clue_2.hide()
	clue_3.hide()
	timer.stop()
