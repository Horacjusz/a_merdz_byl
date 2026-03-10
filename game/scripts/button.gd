extends Sprite2D

signal clicked

func _on_button_down() -> void:
	$ButtonClick.play()
	clicked.emit()
