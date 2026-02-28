extends Riddle

var velocity := 0.0
const MAX_VELOCITY := 200.0
const MIN_VELOCITY := -300.0
const VELOCITY_CHANGE := 500.0
const SLIDER_LEN := 256.0  # hacky :/

var score := 0.0

func jump() -> void:
	velocity = MAX_VELOCITY

func get_height() -> float:
	var pos: float = $Slider/Indicator.position.x
	@warning_ignore("integer_division")
	return (SLIDER_LEN/2 - pos) / SLIDER_LEN

func _physics_process(delta: float) -> void:
	var ind = $"Slider/Indicator";
	ind.position.x -= delta * velocity
	ind.position.x = clampf(ind.position.x, -SLIDER_LEN/2, SLIDER_LEN/2)
	
	velocity -= VELOCITY_CHANGE * delta
	if velocity < MIN_VELOCITY: velocity = MIN_VELOCITY

func _process(delta: float) -> void:
	var pos = get_height()
	if 0.6 < pos and pos < 0.8:
		score += 1 * delta
	else:
		score -= 0.5 * delta
	
	if score < 0: score = 0
	$Label.text = str(score)
	if score > 1: solve()
