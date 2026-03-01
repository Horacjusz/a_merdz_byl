extends Node2D

@onready var normal: TileMapLayer = $Normal
@onready var strange: TileMapLayer = $Strange

var another_world = false

func change_world() :
	another_world = !another_world
