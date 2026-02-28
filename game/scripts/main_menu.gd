extends Control


signal start_game

@onready var main_menu: MarginContainer = $MainMenuContainer
@onready var options_menu: Control = $OptionsMenu
@onready var credits_menu: Control = $CreditsMenu


func _on_start_button_pressed() -> void:
	start_game.emit()


func _on_options_button_pressed() -> void:
	main_menu.visible = false
	options_menu.visible = true


func _on_credits_button_pressed() -> void:
	main_menu.visible = false
	credits_menu.visible = true


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_options_menu_exit_options_menu() -> void:
	options_menu.visible = false
	main_menu.visible = true


func _on_credits_menu_exit_credits_menu() -> void:
	credits_menu.visible = false
	main_menu.visible = true
