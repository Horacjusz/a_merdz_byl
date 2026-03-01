extends Area2D
@onready var fountain: Node2D = $".."

func interact(player) -> void:
	fountain.interact(player)
