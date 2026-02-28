extends Node
class_name Riddle

signal solved

var in_progress := true

func solve():
	if in_progress:
		in_progress = false
		solved.emit()
