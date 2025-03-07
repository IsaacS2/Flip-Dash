class_name LevelManager

extends Node2D

signal notify_game_manager
signal on_game_over

@onready var player: Player = %Player
@onready var cameras: CameraManager = $Cameras


func _ready() -> void:
	#if (player): player.on_death.connect(_reset_for_checkpoint)
	if (cameras): 
		cameras.on_death.connect(_reset_for_checkpoint)
		cameras.on_time_up.connect(_reset_level)
		cameras.on_flip.connect(_on_cameras_on_flip)

func _process(delta: float) -> void:
	pass

func _on_cameras_on_flip() -> void:
	emit_signal("notify_game_manager")

func _flip_things() -> void:
	if (player): player._flip_velocity()
	if (cameras): cameras._flip_camera()

func _reset_for_checkpoint():
	get_tree().call_group("Enemy", "_reenable")
	if (player):
		player._reposition()
		player.velocity = Vector2.ZERO
		player.direction = 1
		player.player_sprite.scale.x = 1
	if (cameras && cameras.activeCamera == cameras.back):
		cameras._flip_camera()
		cameras.position.x = player.position.x

func _reset_player() -> void:
	print("Gotcha")
	if (player && player.deathBuffer <= 0): player._return_velocity()

func _reset_level():
	emit_signal("on_game_over")
	player._sent_spawn_point(Vector2.ZERO)
	_reset_player()
	_reset_for_checkpoint()
	get_tree().call_group("Checkpoints", "_reset_checkpoint")
	if (cameras): cameras._reset_timer()
