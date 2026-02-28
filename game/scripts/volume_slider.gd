extends Node2D


@export var bus_name: String

@onready var slider: Node2D = $Slider

var bus_index: int
var bus_value: float


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	bus_value = _get_normalized_bus_value()
	slider.set_value(bus_value)


func _process(_delta: float) -> void:
	if abs(bus_value - slider.value) > 0.01:
		bus_value = slider.value
		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(slider.value)
		)
		
		
func _get_normalized_bus_value() -> float:
	return db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	) / 2
