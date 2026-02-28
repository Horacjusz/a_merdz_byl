extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

const SPEED = 100

# seconds
var STEP_DURATION = 0.3

enum MOVE_DIRECTION {front, right, back, left}
enum PLAYER_MOVE_STATE {idle, moving}

var direction
var prev_timer

var current_player_move_state

var previous_frame: int

var ANIMATION_MAP = {
	MOVE_DIRECTION.front: {
		PLAYER_MOVE_STATE.idle: ["idle_front", 0],
		PLAYER_MOVE_STATE.moving: ["front", 0]
	},
	MOVE_DIRECTION.right: {
		PLAYER_MOVE_STATE.idle: ["idle_right", 0],
		PLAYER_MOVE_STATE.moving: ["right", 0]
	},
	MOVE_DIRECTION.back: {
		PLAYER_MOVE_STATE.idle: ["idle_back", 0],
		PLAYER_MOVE_STATE.moving: ["back", 0]
	},
	MOVE_DIRECTION.left: {
		PLAYER_MOVE_STATE.idle: ["idle_left", 0],
		PLAYER_MOVE_STATE.moving: ["left", 0]
	}
}


func _update_animation(delta: float) -> void:
	sprite.play(ANIMATION_MAP[direction][current_player_move_state][0])
	sprite.frame_progress = ANIMATION_MAP[direction][current_player_move_state][1]
	
	previous_frame = -1

func _physics_process(delta: float) -> void:
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var previous_player_move_state = current_player_move_state
	var previous_direction = direction
	current_player_move_state = PLAYER_MOVE_STATE.moving
	
	if input_direction[1] < 0:
		direction = MOVE_DIRECTION.front
	elif input_direction[1] > 0:
		direction = MOVE_DIRECTION.back
	elif input_direction[0] > 0:
		direction = MOVE_DIRECTION.right
	elif input_direction[0] < 0:
		direction = MOVE_DIRECTION.left
	else :
		current_player_move_state = PLAYER_MOVE_STATE.idle
	
	if (previous_direction != direction) or (previous_player_move_state != current_player_move_state) :
		_update_animation(delta)
	
	if current_player_move_state == PLAYER_MOVE_STATE.moving :
		if prev_timer < timer.time_left :
			if previous_frame != sprite.frame :
				previous_frame = sprite.frame
				_play_footstep()
	prev_timer = timer.time_left
				
	ANIMATION_MAP[direction][current_player_move_state][1] += delta

	print(position)
		
	velocity = input_direction * SPEED
	move_and_slide()
	

func _ready() -> void :
	timer.start(STEP_DURATION)
	current_player_move_state = PLAYER_MOVE_STATE.idle
	direction = MOVE_DIRECTION.front
	prev_timer = float('inf')
	_update_animation(0)

func _play_footstep() -> void :
	FootstepSoundManager.play_footstep(global_position)
