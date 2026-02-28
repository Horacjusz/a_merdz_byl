extends Node

signal level_requested(target_level: String, target_door_id: String)


func request_level(target_level: String, target_door_id: String) -> void:
	emit_signal("level_requested", target_level, target_door_id)
