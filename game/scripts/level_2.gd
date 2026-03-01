extends Level


@onready var foreground_1: TileMapLayer = $Foreground1
@onready var foreground_2: TileMapLayer = $Foreground2


func reveal_map(ink_level: int = 0) -> void:
	foreground_1.visible = false
	foreground_1.collision_enabled = false
	foreground_2.visible = true
	foreground_2.collision_enabled = true
	

func hide_map() -> void:
	foreground_2.visible = false
	foreground_2.collision_enabled = false
	foreground_1.visible = true
	foreground_1.collision_enabled = true
