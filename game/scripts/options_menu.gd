extends Control


signal exit_options_menu

#@onready var volume_slider: Node2D = $MarginContainer/VolumeSlider


func _on_back_button_pressed() -> void:
	exit_options_menu.emit()
