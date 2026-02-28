extends Control


signal transition_finished

@onready var color_rect: ColorRect = $ColorRect
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	visible = false


func transition() -> void:
	animation_player.play("fade_out")


func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_out":
		transition_finished.emit()
		animation_player.play("fade_in")
