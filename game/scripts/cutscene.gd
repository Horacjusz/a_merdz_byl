extends Node2D
@onready var cutscene: Node2D = $"."
@onready var display_frame: Sprite2D = $DisplayFrame
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var frames = []
var current_frame = -1
var prev_frame = -1
func play_door(new_frames) -> void:
	set_frames(new_frames)
	await _play(0.3)

func play_prologue() -> void:
	set_frames([
		load("res://assets/cutscene_asset/Prologue1.png"),
		load("res://assets/cutscene_asset/Prologue2.png"),
		load("res://assets/cutscene_asset/Prologue3.png"),
		load("res://assets/cutscene_asset/Prologue4.png"),
		load("res://assets/cutscene_asset/Prologue5.png"),
		load("res://assets/cutscene_asset/Prologue6.png"),
		load("res://assets/cutscene_asset/Prologue7.png"),
	])
	await _play(1)

func play_escape_ending() -> void:
	set_frames([load("res://assets/cutscene_asset/Escape_ending.png")])
	await _play(0.2)

func play_insane_ending() -> void:
	set_frames([load("res://assets/cutscene_asset/Insanity_ending.png")])
	await _play(0.2)

func play_vine_ending() -> void:
	set_frames([load("res://assets/cutscene_asset/Vine_ending.png")])
	await _play(0.2)

func _play(speed_scale) -> void:
	cutscene.z_index = 100
	cutscene.visible = true
	display_frame.self_modulate = 0
	animation_player.speed_scale = speed_scale

	for frame in frames:
		display_frame.texture = frame
		animation_player.play("show")
		await animation_player.animation_finished

	cutscene.visible = false
	cutscene.z_index = -100


func set_frames(new_frames) :
	frames = new_frames

func _ready() :
	cutscene.visible = false
	cutscene.z_index = -100
