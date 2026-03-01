extends Node2D


@onready var world: Node = $World
@onready var level_container: Node2D = $World/LevelContainer
@onready var player: CharacterBody2D = $World/Player
@onready var main_menu: Control = $UI/MainMenu
@onready var transition_screen: Control = $UI/TransitionScreen
@onready var bar: Node2D = $World/HUD/Bar
@onready var map: TextureButton = $World/HUD/Map


var current_level: Node = null


func _ready() -> void:
	LevelManager.connect("level_requested", Callable(self, "_on_level_requested"))
	

func _input(event) -> void:
	if event.is_action_pressed("ui_cancel"):
		if current_level:
			if main_menu.visible:
				resume_game()
			else:
				pause_game()
		else:
			exit_game()


func start_game() -> void:
	transition_screen.transition()
	await transition_screen.transition_finished
	main_menu.hide()
	main_menu.change_to_pause_menu()
	player.visible = true
	LevelManager.request_level("level_test", "start", true)


func pause_game() -> void:
	transition_screen.transition()
	await transition_screen.transition_finished
	world.process_mode = Node.PROCESS_MODE_DISABLED
	main_menu.show()


func resume_game() -> void:
	transition_screen.transition()
	await transition_screen.transition_finished
	world.process_mode = Node.PROCESS_MODE_INHERIT
	main_menu.hide()
	
	
func exit_game() -> void:
	get_tree().quit()


func _load_level(
	target_level: PackedScene, 
	target_door_id: String, 
	skip_transition_animation: bool = false,
):
	if not skip_transition_animation:
		transition_screen.transition()
		await transition_screen.transition_finished
		
	if current_level:
		current_level.queue_free()
		
	current_level = target_level.instantiate()
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


func _on_level_requested(
	target_level: PackedScene, 
	target_door_id: String, 
	skip_transition_animation: bool = false,
):
	call_deferred(
		"_load_level", 
		target_level, 
		target_door_id, 
		skip_transition_animation,
	)


func _on_main_menu_start_button_pressed() -> void:
	if current_level:
		resume_game()
	else:
		start_game()


func _on_main_menu_exit_button_pressed() -> void:
	exit_game()


func _on_map_map_clicked() -> void:
	map.change(current_level.another_world)
	bar.change(current_level.another_world)
	current_level.change_world()
	
	pass # Replace with function body.
