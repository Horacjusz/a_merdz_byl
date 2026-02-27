extends Node2D

@onready var slider_body: Sprite2D = $SliderBody
@onready var slider_knob: TextureButton = $SliderBody/TextureButton

var DEFAULT_VALUE = 0.5

var PERCENTAGE_MARGIN = 0.02

var MIN_KNOB_X = 0
var MAX_KNOB_X = 1
var KNOB_READY = false
var BUTTON_PRESSED = false
var KNOB_WIDTH = 0
var VALUE = DEFAULT_VALUE

func place_knob_correctly(knob, body):
	# please make all knob textures the same shape
	# more like please be
	
	var height_diff = (body.texture.get_size() - knob.texture_normal.get_size()).y
	
	knob.position.y = body.position.y + (height_diff / 2)
	
	var body_length = slider_body.texture.get_size().x
	
	KNOB_WIDTH = knob.texture_normal.get_size().x
	
	MIN_KNOB_X = (slider_body.position.x + (PERCENTAGE_MARGIN * body_length)) + position.x
	MAX_KNOB_X = (slider_body.position.x + ((1 - PERCENTAGE_MARGIN) * body_length) - KNOB_WIDTH) + position.x
	
	knob.position.x = MIN_KNOB_X + (abs(MIN_KNOB_X - MAX_KNOB_X) * DEFAULT_VALUE)
	
	KNOB_READY = true

func _ready() -> void:
	
	place_knob_correctly(slider_knob, slider_body)
	print(position)
	

func normalise_knob_position():
	if KNOB_READY :
		slider_knob.position.x = min(max(slider_knob.position.x, MIN_KNOB_X), MAX_KNOB_X)


func _process(delta: float) -> void:
	if BUTTON_PRESSED :
		
		var mouse_position = get_viewport().get_mouse_position()
		
		slider_knob.position.x = mouse_position.x - (KNOB_WIDTH / 2)
		
		normalise_knob_position()
	
	if KNOB_READY :
		VALUE = snapped((slider_knob.position.x - MIN_KNOB_X) / abs(MIN_KNOB_X - MAX_KNOB_X), 0.0001)
		VALUE = min(max(VALUE, 0), 1)



func _on_texture_button_button_down() -> void:
	BUTTON_PRESSED = true
	normalise_knob_position()
	pass


func _on_texture_button_button_up() -> void:
	BUTTON_PRESSED = false
	normalise_knob_position()
	pass
