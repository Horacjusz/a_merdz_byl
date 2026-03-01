extends TextureButton


signal map_opened
signal map_closed

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var isOpened: bool = false

func open() -> void:
	isOpened = true
	animation_player.play("blacken")
	await animation_player.animation_finished
	animation_player.play("rozwin")
	await animation_player.animation_finished
	animation_player.play("unblacken")
	map_opened.emit()

func close() -> void:
	isOpened = false
	animation_player.play("blacken")
	await animation_player.animation_finished
	animation_player.play("zwin")
	await animation_player.animation_finished
	animation_player.play("unblacken")
	map_closed.emit()

func _on_button_down() -> void:
	if isOpened:
		close()
	else:
		open()
