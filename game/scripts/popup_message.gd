extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var message: Sprite2D = $Message
@onready var popup_message: Node2D = $"."

func _ready() :
	popup_message.hide()

func display(image) :
	popup_message.show()
	message.texture = image
	animation_player.play("display")
	await animation_player.animation_finished
	popup_message.hide()
