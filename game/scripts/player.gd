extends CharacterBody2D

const SPEED = 100

enum MOVE_DIRECTION {front, right, back, left}
var direction = MOVE_DIRECTION.front

func _physics_process(_delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_direction[1] < 0:
		direction = MOVE_DIRECTION.front
	elif input_direction[1] > 0:
		direction = MOVE_DIRECTION.back
	elif input_direction[0] > 0:
		direction = MOVE_DIRECTION.right
	elif input_direction[0] < 0:
		direction = MOVE_DIRECTION.left
		
	velocity = input_direction * SPEED
	move_and_slide()
