extends TextureButton

var holding = false
var is_right = false
var is_in = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if holding:
		var mouse_pos = get_global_mouse_position()
		var direction = mouse_pos - global_position
		rotation = direction.angle() - 0.05
		var distance = global_position.distance_to(mouse_pos)
		scale.x = distance / 550.0



func _on_button_down() -> void:
	holding = true
	is_right = false

func _on_button_up() -> void:
	holding = false
	if is_in:
		is_right=true
		#print("jest")



func _on_mouse_entered() -> void:
	is_in = true


func _on_mouse_exited() -> void:
	is_in = false


func _on_redslot_mouse_exited() -> void:
	pass # Replace with function body.
