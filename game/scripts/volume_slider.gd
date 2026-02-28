extends HSlider


const EPSILON: float = 0.05

@export var bus_name: String

var bus_index: int


func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)
	
	if bus_index < 0:
		return
	
	value = db_to_linear(
		AudioServer.get_bus_volume_db(bus_index)
	)


func _on_value_changed(new_value: float) -> void:
	if bus_index < 0:
		return
	
	var linear_new_value = linear_to_db(new_value)
	
	if linear_new_value < min_value + EPSILON:
		linear_new_value = min_value
	elif linear_new_value > max_value - EPSILON:
		linear_new_value = max_value
	
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_new_value,
	)
