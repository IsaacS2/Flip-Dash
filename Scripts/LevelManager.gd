class_name LevelManager

extends Node2D

signal notify_game_manager

@onready var player: Player = %Player
@onready var cameras: CameraManager = $Cameras


func _ready() -> void:
	if (player): player.on_death.connect(_reset_for_checkpoint)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_cameras_on_flip() -> void:
	emit_signal("notify_game_manager")


func _flip_things() -> void:
	if (player): player._flip_velocity()
	if (cameras): cameras._flip_camera()


func _reset_for_checkpoint():
	player.position = Vector2.ZERO
	player.velocity = Vector2.ZERO
	player.direction = 1
	player.player_sprite.scale.x = 1
	if (cameras.activeCamera == cameras.back):
		cameras._flip_camera()


func _reset_player() -> void:
	player._return_velocity()
