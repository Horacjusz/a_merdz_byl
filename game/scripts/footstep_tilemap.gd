extends TileMapLayer


func _ready() -> void:
	FootstepSoundManager.add_tilemap(self)

func _exit_tree() -> void:
	FootstepSoundManager.remove_tilemap(self)
