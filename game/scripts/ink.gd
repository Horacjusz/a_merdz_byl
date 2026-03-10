extends Area2D

var picked := false

func _on_body_entered(body: Node2D) -> void:
	if not picked:
		picked = true
		$SuccessSound.play()
		Inventory.gain_crystal()
		hide()
