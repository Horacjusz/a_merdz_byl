extends Sprite2D

@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var barpos=1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func next_bar():
	if barpos==1:
		animation_player.play("lv1")
		barpos+=1
	elif barpos==2:
		animation_player.play("lv2")
		barpos+=1
	elif barpos==3:
		animation_player.play("lv3")
		barpos+=1
	elif barpos==4:
		animation_player.play("lv4")
		barpos+=1
	elif barpos==5:
		animation_player.play("RESET")
		barpos=1

func _unhandled_input(event):
	if event.is_action_pressed("spacja"):
		next_bar()
