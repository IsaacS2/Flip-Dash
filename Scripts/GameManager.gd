extends Node

@onready var level: LevelManager = $Level

var flip_pause : bool = false
var flip_pause_timer : float
var flip_pause_total_time : float = 0.18

func _ready() -> void:
	if (level):
		level.notify_game_manager.connect(_pause_for_flip)
		level.on_game_over.connect(_reset_values)
	_reset_values()

func _process(delta: float) -> void:
	if (flip_pause_timer > 0):
		flip_pause_timer -= delta
		
		if (flip_pause_timer <= 0):
			_reset_values()
			level._reset_player()

func _pause_for_flip():
	if (!flip_pause):
		level._flip_things()
		flip_pause = true
		flip_pause_timer = flip_pause_total_time

func _reset_values():
	flip_pause_timer = 0
	flip_pause = false
