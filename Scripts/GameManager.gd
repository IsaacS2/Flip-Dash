class_name GameManager

extends Node

@onready var level: LevelManager = $Level
@export var StartScene : PackedScene = load("res://Scenes/StartScene.tscn")
@export var FirstScene : PackedScene = load("res://Scenes/FirstScene.tscn")
@export var SecondScene : PackedScene = load("res://Scenes/SecondScene.tscn")
@export var Level1 : PackedScene = load("res://Scenes/Level1.tscn")
@export var Level2 : PackedScene = load("res://Scenes/Level2.tscn")
@export var EndScene : PackedScene = load("res://Scenes/EndScene.tscn")

var flip_pause : bool = false
var levelNum : int = 0
var flip_pause_timer : float
var flip_pause_total_time : float = 0.18

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if (flip_pause_timer > 0):
		flip_pause_timer -= delta
		
		if (flip_pause_timer <= 0):
			_reset_values()
			if (level): level._reset_player()

func _pause_for_flip():
	print("whatt?")
	if (!flip_pause):
		print("nice")
		level._flip_things()
		flip_pause = true
		flip_pause_timer = flip_pause_total_time

func _reset_values():
	flip_pause_timer = 0
	flip_pause = false

func _start_level():
	level = get_child(1)
	if (level is LevelManager):
		level.notify_game_manager.connect(_pause_for_flip)
		level.on_game_over.connect(_reset_values)
	_reset_values()

func _to_next_scene():
	var child = get_child(0)
	if (child.name == "StartScene"):
		child.queue_free()
		var scene = FirstScene.instantiate()
		add_child(scene)
	elif (child.name == "FirstScene"):
		child.queue_free()
		var scene = SecondScene.instantiate()
		add_child(scene)
	elif (child.name == "SecondScene"):
		child.queue_free()
		var scene = Level1.instantiate()
		add_child(scene)
		_start_level()
	elif (child.name == "Level" && levelNum == 0):
		levelNum = 1
		child.queue_free()
		var scene = Level2.instantiate()
		add_child(scene)
		_start_level()
	elif (levelNum == 1):
		child.queue_free()
		var scene = EndScene.instantiate()
		add_child(scene)
