extends TextureButton

signal map_clicked

@onready var level_container: Node2D = $"../../World/LevelContainer"

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bar: Node2D = $"../Bar"

var another_world=false

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
	

func change(another_world: bool) :
	if another_world:
		animation_player.play("zwin")
	else:
		animation_player.play("rozwin")

func _on_button_down() -> void:
	map_clicked.emit()
