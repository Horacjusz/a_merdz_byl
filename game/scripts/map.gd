extends TextureButton


signal map_clicked

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change(another_world: bool) :
	if another_world:
		animation_player.play("zwin")
	else:
		animation_player.play("rozwin")


func _on_button_down() -> void:
	map_clicked.emit()
