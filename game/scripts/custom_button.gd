extends TextureButton


@onready var hover_texture: TextureRect = $HoverTexture
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hover_sound := $HoverSound


func _ready() -> void:
	hover_texture.hide()


func _on_mouse_entered() -> void:
	animation_player.play("hover_enter")
	hover_sound.play()


func _on_mouse_exited() -> void:
	animation_player.play("hover_exit")
