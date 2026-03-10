extends Node

var crystal_count := 0

var info_message = preload("uid://cct1uj5gmb10r")

var DISPLAY = false

func _ready() -> void :
	crystal_count = 0

func gain_crystal() -> void :
	crystal_count += 1
	DISPLAY = true

func use_crystal() -> void :
	crystal_count -= 1
	

func check_display() :
	if DISPLAY :
		DISPLAY = false
		return true
	return false
