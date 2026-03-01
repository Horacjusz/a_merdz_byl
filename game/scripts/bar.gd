extends Node2D

@onready var inside: Sprite2D = $Inside

var Y_TRAVEL := 120.0 * scale.y
var CLIP_HEIGHT := 50 * scale.y
var BAR_FREEZED = false

# travel_rate is showing how much bar is gonna raise in 1 second
@export var travel_rate := 0.1
var _target_percentage: float = 0.0
var value: float = 0.0

func _ready() -> void:
	_set_position_to_value()
	_update_clip()
	increase(1)
	freeze()
	
func freeze() :
	BAR_FREEZED = true
	
func unfreeze() :
	BAR_FREEZED = false

func change(another_world: bool) :
	if another_world:
		freeze()
	else:
		unfreeze()


func increase(increase_value: float) -> void:
	unfreeze()
	_target_percentage = clamp(_target_percentage + increase_value, 0.0, 1.0)

func _set_position_to_value() -> void:
	inside.position.y = Y_TRAVEL * (1.0 - value)

func _update_clip() -> void:
	var clip_line_y := global_position.y + CLIP_HEIGHT

	var mat := inside.material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("clip_y", clip_line_y)

func _process(delta: float) -> void:
	if not BAR_FREEZED :
		var difference := _target_percentage - value
		if difference != 0.0:
			value = clamp(value + travel_rate * delta * sign(difference), 0.0, 1.0)
			_set_position_to_value()
		_update_clip()
	
