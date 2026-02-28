extends Node

signal level_requested(target_level: String, target_door_id: String)

var level_map := {
	"level_1": preload("res://scenes/levels/level_1.tscn"),
	"level_2": preload("res://scenes/levels/level_2.tscn"),
}


func request_level(
	target_level_id: String, 
	target_door_id: String, 
	skip_transition_animation: bool = false,
) -> void:
	if not level_map.has(target_level_id):
		push_error("Level '%s' not found in database!" % target_level_id)
		return

	level_requested.emit(
		level_map[target_level_id], 
		target_door_id, 
		skip_transition_animation,
	)
