extends Sprite2D

signal clicked

@onready var button := $Button

func _on_good_button_button_down() -> void:
	if not button.disabled:
		button.disabled = true
		$ButtonClick.play()
		clicked.emit()
