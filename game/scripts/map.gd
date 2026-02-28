extends TextureButton

@onready var tile_map1: TileMapLayer = $"../../TileMapLayer"
@onready var tile_map2: TileMapLayer = $"../../TileMapLayer2"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bar: Node2D = $"../Bar"


var another_world=false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	



func _on_button_down() -> void:
	if another_world:
		animation_player.play("zwin")
		bar.freeze()
	else:
		animation_player.play("rozwin")
		bar.start()
	
	another_world = !another_world
	tile_map2.collision_enabled = !tile_map2.collision_enabled
	tile_map2.visible = !tile_map2.enabled
	tile_map1.collision_enabled = tile_map1.collision_enabled
	tile_map1.visible = !tile_map1.enabled
