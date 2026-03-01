extends Riddle

@onready var stone_1: Sprite2D = $Sprite2D/stone1
@onready var stone_2: Sprite2D = $Sprite2D/stone2
@onready var stone_3: Sprite2D = $Sprite2D/stone3

func _process(delta: float) -> void:
	if stone_1.texid==5 and stone_2.texid==1 and stone_3.texid==4:
		solve()
