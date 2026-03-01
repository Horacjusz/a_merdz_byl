extends Area2D
@onready var door: Node2D = $".."

func interact(player) -> void:
	door.interact(player)
