extends Riddle

var velocity := 0.0
const MAX_VELOCITY := 500.0
const MIN_VELOCITY := -800.0
const VELOCITY_CHANGE := 1500.0
const SLIDER_LEN := 600.0  # hacky :/

var score := 0.0

func jump() -> void:
	velocity = MAX_VELOCITY

func get_height() -> float:
	var pos: float = $Slider/Indicator.position.y
	return (SLIDER_LEN/2 - pos) / SLIDER_LEN

func _physics_process(delta: float) -> void:
	var ind = $"Slider/Indicator";
	ind.position.y -= delta * velocity
	ind.position.y = clampf(ind.position.y, -SLIDER_LEN/2, SLIDER_LEN/2)
	
	velocity -= VELOCITY_CHANGE * delta
	if velocity < MIN_VELOCITY: velocity = MIN_VELOCITY

func _process(delta: float) -> void:
	var pos = get_height()
	if 0.6 < pos and pos < 0.8:
		score += 1 * delta
	else:
		score -= 0.5 * delta
	
	if score < 0: score = 0
	if $Indicator/Arrow.rotation < PI/2:
		$Indicator/Arrow.rotation = -PI/2 + score * PI
	
	if score >= 1: solve()
