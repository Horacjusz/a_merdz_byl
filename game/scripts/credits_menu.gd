extends Control


signal exit_credits_menu


func _on_back_button_pressed() -> void:
	exit_credits_menu.emit()
