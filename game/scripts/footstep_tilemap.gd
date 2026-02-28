extends TileMapLayer


func _ready() -> void:
	FootstepSoundManager.add_tilemap(self)
