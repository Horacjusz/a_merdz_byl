extends Node2D

@onready var f_button: Sprite2D = $"CanvasLayer/F-button"


func interact(player: Player) :
	player.open_last_door()


func _on_range_body_entered(body: Node2D) -> void:
	if body is Player :
		f_button.show()

func _on_range_body_exited(body: Node2D) -> void:
	if body is Player :
		f_button.hide()

#func _take_a_sip(player) -> void :
	#if f_button.visible :
		#player.take_a_sip(sip_value)
		#f_button.hide()
