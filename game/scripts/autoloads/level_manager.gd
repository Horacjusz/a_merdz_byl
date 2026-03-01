extends Node

signal level_requested(target_level: String, target_door_id: String)

var level_map := {
	"level_1": preload("res://scenes/levels/level_1.tscn"),
	"level_2": preload("res://scenes/levels/level_2.tscn"),
	"level_3": preload("res://scenes/levels/level_3.tscn"),
	"fountain_1": preload("res://scenes/levels/level_fountain_1.tscn"),
	"fountain_2": preload("res://scenes/levels/level_fountain_2.tscn"),
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
