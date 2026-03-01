extends TextureButton


signal map_opened
signal map_closed

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var isOpened: bool = false

func change(another_world: bool) :
	animation_player.play("blacken")
	await animation_player.animation_finished
	
	if another_world:
		animation_player.play("zwin")
	else:
		animation_player.play("rozwin")
	
	await animation_player.animation_finished
	animation_player.play("unblacken")


func open() -> void:
	isOpened = true
	animation_player.play("rozwin")
	

func close() -> void:
	isOpened = false
	animation_player.play("zwin")


func _on_button_down() -> void:
	if isOpened:
		map_closed.emit()
	else:
		map_opened.emit()
