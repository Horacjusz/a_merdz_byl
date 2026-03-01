class_name Player
extends CharacterBody2D

signal sip_taken(sip_value: float)

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D
@onready var interaction_area: Area2D = $InteractionArea

const SPEED: float = 200.0
var STEP_DURATION: float = 0.3

enum MOVE_DIRECTION { front, right, back, left }
enum PLAYER_MOVE_STATE { idle, moving }

var direction: int = MOVE_DIRECTION.front
var current_player_move_state: int = PLAYER_MOVE_STATE.idle
var previous_frame: int = -1

var footstep_cooldown_left: float = 0.0

var ANIMATION_MAP = {
	MOVE_DIRECTION.front: {
		PLAYER_MOVE_STATE.idle: ["idle_front", 0.0],
		PLAYER_MOVE_STATE.moving: ["front", 0.0]
	},
	MOVE_DIRECTION.right: {
		PLAYER_MOVE_STATE.idle: ["idle_right", 0.0],
		PLAYER_MOVE_STATE.moving: ["right", 0.0]
	},
	MOVE_DIRECTION.back: {
		PLAYER_MOVE_STATE.idle: ["idle_back", 0.0],
		PLAYER_MOVE_STATE.moving: ["back", 0.0]
	},
	MOVE_DIRECTION.left: {
		PLAYER_MOVE_STATE.idle: ["idle_left", 0.0],
		PLAYER_MOVE_STATE.moving: ["left", 0.0]
	}
}

var anim_state := {} # animation_name -> { "frame": int, "progress": float }

func _ready() -> void:
	_update_animation()

func _save_current_anim_state() -> void:
	if sprite.animation == "":
		return

	anim_state[sprite.animation] = {
		"frame": sprite.frame,
		"progress": sprite.frame_progress
	}


func _restore_anim_state(anim_name: String) -> void:
	var s = anim_state.get(anim_name, null)
	if s == null:
		return

	# Godot 4: you can usually set these directly.
	sprite.frame = s["frame"]
	sprite.frame_progress = s["progress"]

func _update_animation() -> void:
	_save_current_anim_state()

	var anim_name: String = ANIMATION_MAP[direction][current_player_move_state][0]

	# play() resets to the beginning, so we restore immediately after
	sprite.play(anim_name)
	_restore_anim_state(anim_name)

	previous_frame = -1

func _physics_process(delta: float) -> void:
	footstep_cooldown_left = maxf(0.0, footstep_cooldown_left - delta)

	var input_direction: Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	var previous_player_move_state: int = current_player_move_state
	var previous_direction: int = direction
	current_player_move_state = PLAYER_MOVE_STATE.moving

	if input_direction.y < 0:
		direction = MOVE_DIRECTION.front
	elif input_direction.y > 0:
		direction = MOVE_DIRECTION.back
	elif input_direction.x > 0:
		direction = MOVE_DIRECTION.right
	elif input_direction.x < 0:
		direction = MOVE_DIRECTION.left
	else:
		current_player_move_state = PLAYER_MOVE_STATE.idle

	if (previous_direction != direction) or (previous_player_move_state != current_player_move_state):
		_update_animation()

	if current_player_move_state == PLAYER_MOVE_STATE.moving:
		if previous_frame != sprite.frame:
			previous_frame = sprite.frame
			_try_play_footstep()

	ANIMATION_MAP[direction][current_player_move_state][1] += delta

	velocity = input_direction * SPEED
	move_and_slide()
	
	if Input.is_action_just_pressed("press_F_to_pay_respect") :
		var overlapping = interaction_area.get_overlapping_areas()
		for area in overlapping :
			print(area)
			if area.has_method("interact") :
				area.interact(self)
				
func take_a_sip(sip_value: float) :
	sip_taken.emit(sip_value)

func _try_play_footstep() -> void:
	if footstep_cooldown_left > 0.0:
		return

	footstep_cooldown_left = STEP_DURATION
	FootstepSoundManager.play_footstep(global_position)


func change_global_position(new_global_position: Vector2) -> void:
	global_position = new_global_position
	camera.reset_smoothing()
