extends Riddle

@onready var blue_wire: TextureButton = $background/blueWire
@onready var red_wire: TextureButton = $background/redWire
@onready var green_wire: TextureButton = $background/greenWire


func _process(_delta: float) -> void:
	if blue_wire.is_right and green_wire.is_right and red_wire.is_right:
		solve()
