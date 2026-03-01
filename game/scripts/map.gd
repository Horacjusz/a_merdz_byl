extends TextureButton


signal map_clicked

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var screen_black = false

func toogle_black_screen() :
	if screen_black :
		animation_player.play("unblacken")
	else :
		animation_player.play("blacken")

func change(another_world: bool) :
	animation_player.play("blacken")
	await animation_player.animation_finished
	
	if another_world:
		animation_player.play("zwin")
	else:
		animation_player.play("rozwin")
	
	await animation_player.animation_finished
	animation_player.play("unblacken")

func _on_button_down() -> void:
	map_clicked.emit()
