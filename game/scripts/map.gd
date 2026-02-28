extends TextureButton

@onready var tile_map1: TileMapLayer = $"../../TileMapLayer"
@onready var tile_map2: TileMapLayer = $"../../TileMapLayer2"
@onready var animation_player: AnimationPlayer = $AnimationPlayer


var another_world=false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	



func _on_button_down() -> void:
	if another_world:
		animation_player.play("zwin")
		another_world=false
		tile_map2.collision_enabled=false
		tile_map2.visible=false
		tile_map1.collision_enabled=true
		tile_map1.visible=true
	else:
		animation_player.play("rozwin")
		another_world=true
		tile_map2.collision_enabled=true
		tile_map2.visible=true
		tile_map1.collision_enabled=false
		tile_map1.visible=false
