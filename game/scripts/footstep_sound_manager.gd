extends Node

var tilemaps: Array[TileMapLayer] = []

const footstep_sounds = {
	"default": [
		preload("res://assets/sounds/Footsteps/data_pion-st1-footstep-sfx-323053.mp3"),
		preload("res://assets/sounds/Footsteps/data_pion-st2-footstep-sfx-323055.mp3"),
		preload("res://assets/sounds/Footsteps/data_pion-st3-footstep-sfx-323056.mp3"),
	],
	"stone": [
		preload("res://assets/sounds/Gate/alex_jauk-fence-gate-slammed-227012.mp3")
	],
	"bush": [
		preload("res://assets/sounds/Item/item-pickup.mp3")
	]
}

func add_tilemap(tilemap: TileMapLayer) -> void :
	tilemaps.push_back(tilemap)


func play_footstep(position: Vector2) -> void:
	var tile_data = []
	for tilemap in tilemaps :
		var tile_position = tilemap.local_to_map(position)
		var data = tilemap.get_cell_tile_data(tile_position)
		if data :
			tile_data.push_back(data)
	
	var footstep_sound = footstep_sounds["default"].pick_random()
	
	if tile_data.size() > 0 :
		var tile_type = tile_data.back().get_custom_data("footstep_sound")
		
		if footstep_sounds.has(tile_type) :
			footstep_sound = footstep_sounds[tile_type].pick_random()
			
			
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.stream = footstep_sound
	get_tree().root.add_child(audio_player)
	audio_player.global_position = position
	
	audio_player.play()
	await audio_player.finished
	audio_player.queue_free()
