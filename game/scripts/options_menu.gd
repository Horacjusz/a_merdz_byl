extends Control


signal exit_options_menu


func _on_back_button_pressed() -> void:
	$SelectionClick.play()
	exit_options_menu.emit()
