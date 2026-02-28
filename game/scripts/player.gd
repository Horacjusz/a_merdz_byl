class_name Player
extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite2D

const SPEED = 200

enum MOVE_DIRECTION {front, right, back, left}
var direction = MOVE_DIRECTION.front

func _play_idle():
	match direction:
		MOVE_DIRECTION.right:
			sprite.play("right")
		MOVE_DIRECTION.left:
			sprite.play("left")
		MOVE_DIRECTION.front:
			sprite.play("front")
		MOVE_DIRECTION.back:
			sprite.play("back")
			


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
	
	_play_idle()
		
	velocity = input_direction * SPEED
	move_and_slide()
	#_play_footstep()

func _play_footstep() -> void :
	FootstepSoundManager.play_footstep(global_position)
