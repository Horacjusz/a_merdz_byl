extends Node2D


@onready var level_container: Node2D = $LevelContainer
@onready var player: CharacterBody2D = $Player

var current_level: Node = null


func _ready() -> void:
	current_level = level_container.get_child(0)
	LevelManager.connect("level_requested", Callable(self, "_on_level_requested"))


func _load_level(target_level: String, target_door_id: String):
	print(target_level)
	
	
	if current_level:
		current_level.queue_free()
		
	current_level = load(target_level).instantiate()
	level_container.add_child(current_level)
	
	if target_door_id:
		_position_player_at_door(target_door_id)


func _position_player_at_door(target_door_id: String):
	var doors_node = current_level.get_node("Doors") if current_level.has_node("Doors") else null
	if not doors_node:
		push_warning("No Doors node found in current level!")
		return

	for door in doors_node.get_children():
		if door.door_id == target_door_id and door.has_node("Spawn"):
			player.global_position = door.get_node("Spawn").global_position
			return

	push_warning("Door with id '%s' not found!" % target_door_id)


func _on_level_requested(target_level: String, target_door_id: String):
	call_deferred("_load_level", target_level, target_door_id)
