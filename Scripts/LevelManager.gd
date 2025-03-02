class_name LevelManager

extends Node2D

signal notify_game_manager

@onready var player: Player = %Player
@onready var cameras: CameraManager = $Cameras


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cameras_on_flip() -> void:
	emit_signal("notify_game_manager")


func _flip_things() -> void:
	if (player): player._flip_velocity()
	if (cameras): cameras._flip_camera()

func _reset_player() -> void:
	player._return_velocity()
