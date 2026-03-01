extends Node2D

signal insanity_reached
signal bar_expired
signal bar_started

@onready var inside: Sprite2D = $Inside
@onready var secondary_inside: Sprite2D = $Secondary_Inside

var Y_TRAVEL := 120.0 * scale.y
var CLIP_HEIGHT := 50 * scale.y
var BAR_FREEZED = false

# travel_rate is showing how much bar is gonna raise in 1 second
@export var travel_rate := 0.1
var _target_percentage: float = 0.0
var _secondary_target: float = 0.0
var value: float = 0.0
var secondary_value: float = 0.0

func _ready() -> void:
	_set_position_to_value()
	_set_secondary_position_to_value()
	_update_clip(inside)
	_update_clip(secondary_inside)
	increase(1)
	freeze()
	
func freeze() :
	BAR_FREEZED = true
	_secondary_target = 0.0
	
func unfreeze() :
	BAR_FREEZED = false
	_secondary_target = _target_percentage
	bar_started.emit()

func change(another_world: bool) :
	if another_world:
		freeze()
	else:
		unfreeze()



func take_a_sip(sip_value: float) -> void :
	increase(-sip_value)

func increase(increase_value: float) -> void:
	_target_percentage = clamp(_target_percentage + increase_value, 0.0, 1.0)
	unfreeze()

func _set_position_to_value() -> void:
	inside.position.y = Y_TRAVEL * (1.0 - value)

func _set_secondary_position_to_value() :
	secondary_inside.position.y = Y_TRAVEL * (1.0 - secondary_value)

func _update_clip(insider) -> void:
	var clip_line_y := global_position.y + CLIP_HEIGHT

	var mat := insider.material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("clip_y", clip_line_y)

func _process(delta: float) -> void:
	if not BAR_FREEZED :
		var difference := _target_percentage - value
		if difference != 0.0:
			value = clamp(value + travel_rate * delta * sign(difference), 0.0, 1.0)
			_set_position_to_value()
		_update_clip(inside)
		
	var secondary_difference := _secondary_target - secondary_value
	if secondary_difference != 0.0 :
		secondary_value = clamp(secondary_value + travel_rate * delta * sign(secondary_difference), 0.0, value)
		_set_secondary_position_to_value()
	_update_clip(secondary_inside)
	
	if secondary_value == 0 :
		bar_expired.emit()
	if value == 1 :
		insanity_reached.emit()
	if value == 0 :
		increase(1)
		freeze()
