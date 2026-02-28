extends Control


signal start_button_pressed()
signal exit_button_pressed()

@onready var main_menu: MarginContainer = $MainMenuContainer
@onready var options_menu: Control = $OptionsMenu
@onready var credits_menu: Control = $CreditsMenu
@onready var start_button: TextureButton = $MainMenuContainer/VBoxContainer/StartButton
@onready var continue_button: TextureButton = $MainMenuContainer/VBoxContainer/ContinueButton


func _ready() -> void:
	change_to_start_menu()


func change_to_start_menu() -> void:
	start_button.show()
	continue_button.hide()


func change_to_pause_menu() -> void:
	start_button.hide()
	continue_button.show()


func _on_start_button_pressed() -> void:
	start_button_pressed.emit()


func _on_continue_button_pressed() -> void:
	start_button_pressed.emit()


func _on_options_button_pressed() -> void:
	main_menu.visible = false
	options_menu.visible = true


func _on_credits_button_pressed() -> void:
	main_menu.visible = false
	credits_menu.visible = true


func _on_exit_button_pressed() -> void:
	exit_button_pressed.emit()


func _on_options_menu_exit_options_menu() -> void:
	options_menu.visible = false
	main_menu.visible = true


func _on_credits_menu_exit_credits_menu() -> void:
	credits_menu.visible = false
	main_menu.visible = true
