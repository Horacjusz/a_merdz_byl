class_name Door
extends Area2D


@export var door_id: String
@export var target_level_id: String
@export var target_door_id: String

@onready var spawn: Marker2D = $Spawn


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		LevelManager.request_level(target_level_id, target_door_id)
