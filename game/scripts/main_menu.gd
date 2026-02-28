extends Control


signal start_game

@onready var buttons_v_box: VBoxContainer = $MarginContainer/VBoxContainer
@onready var options_menu: Control = $OptionsMenu
@onready var margin_container: MarginContainer = $MarginContainer


func _ready() -> void:
	focus_button()

func _on_visibility_changed() -> void:
	if visible:
		focus_button()


func focus_button() -> void:
	if buttons_v_box and buttons_v_box.get_child_count() > 0:
		var first := buttons_v_box.get_child(0)
		if first is Button:
			first.grab_focus()


func _on_start_button_pressed() -> void:
	start_game.emit()


func _on_options_button_pressed() -> void:
	margin_container.visible = false
	options_menu.visible = true


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_options_menu_exit_options_menu() -> void:
	options_menu.visible = false
	margin_container.visible = true


func _on_credits_button_pressed() -> void:
	pass # Replace with function body.
