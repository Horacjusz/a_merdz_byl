extends Riddle

var symbols = [
	load("res://assets/riddles_asset/Symbo1.png"),
	load("res://assets/riddles_asset/Symbol2.png"),
	load("res://assets/riddles_asset/Symbol3.png"),
	load("res://assets/riddles_asset/Symbol4.png"),
	load("res://assets/riddles_asset/Symbol5.png"),
	load("res://assets/riddles_asset/Symbol6.png"),
	load("res://assets/riddles_asset/Symbol7.png"),
	load("res://assets/riddles_asset/Symbol8.png"),
	load("res://assets/riddles_asset/Symbol9.png"),
	load("res://assets/riddles_asset/Symbol10.png"),
]
const SYMBOLS_ON_SCREEN := 7

@onready var circles = [$InnerCircle, $MiddleCircle, $OuterCircle]
const RADIUSES: Array[float] = [105.0, 245.0, 390.0]

var solution: int
var circle_symbols: Array
var positions := [0, 0, 0]

func _ready() -> void:
	shuffle_symbols()
	for i in range(3):
		add_symbols(circles[i], circle_symbols[i], RADIUSES[i])

func handle_event(circle_idx: int, event: InputEvent):
	# Move circles when clicked
	if is_instance_of(event, InputEventMouseButton) and event.pressed:
		var direction: int
		match event.button_index:
			MouseButton.MOUSE_BUTTON_LEFT:
				direction = -1
			MouseButton.MOUSE_BUTTON_RIGHT:
				direction = 1
			_:
				return
		
		var circle = circles[circle_idx]
		positions[circle_idx] = posmod(
			(positions[circle_idx] + direction),
			circle_symbols[0].size()
		)
		var rot: float = TAU - positions[circle_idx] * TAU / circle_symbols[0].size()
		# don't do a rotation backwards
		while direction * circle.rotation < direction * rot:
			circle.rotation += direction * TAU
		
		var tween = get_tree().create_tween()
		tween.tween_property(circle, "rotation", rot, 0.1)
		await tween.finished
		
		if (
			selected_symbol(0) == selected_symbol(1)
			and selected_symbol(1) == selected_symbol(2)
		):
			solve()

func selected_symbol(circle_idx: int) -> int:
	return circle_symbols[circle_idx][positions[circle_idx]]

## Redistribute the symbols so that only one will be common among all circles
func shuffle_symbols():
	var n := symbols.size()
	var indices = range(n)
	indices.shuffle()
	indices = indices.slice(0, SYMBOLS_ON_SCREEN)
	
	solution = indices.pop_back()
	# ensure that each circle will have the same number of symbols
	while indices.size() % 3 != 0: indices.pop_back()
	var symbols_out_of_circle = indices.size() / 3
	
	# symbols on each position in every circle
	var shuf_syms = [[solution], [solution], [solution]]
	for i in range(indices.size()):
		for j in range(3):
			if int(i / symbols_out_of_circle) != j:
				shuf_syms[j].append(indices[i])
	for t in shuf_syms: t.shuffle()
	
	circle_symbols = shuf_syms

## Draw symbols on a circle
func add_symbols(circle: Sprite2D, indices: Array, radius: float):
	for i in range(indices.size()):
		var sym := Sprite2D.new()
		sym.texture = symbols[indices[i]]
		var rot := i * TAU / indices.size()
		sym.position = Vector2.UP.rotated(rot) * radius
		sym.rotate(rot)
		circle.add_child(sym)

func input_event(_viewport, event: InputEvent, idx: int):
	handle_event(idx, event)
