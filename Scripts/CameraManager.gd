class_name CameraManager

extends Node2D

signal on_flip
signal on_time_up

var activeCamera: Camera2D
var cameraZoom: int = 1
@onready var front: Camera2D = $Front
@onready var back: Camera2D = $Back
@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer


func _ready() -> void:
	activeCamera = front
	timer.time_up.connect(_time_up_message)


func _process(delta: float) -> void:
	position.x = player.position.x
	
	if (Input.is_action_just_pressed("Flip")): # check if game isn't paused atm
		emit_signal("on_flip")


func _flip_camera() -> void:
	#cameraZoom *= -1
	#activeCamera.zoom.x = cameraZoom
	activeCamera.enabled = false
	activeCamera.visible = false
	if (activeCamera == front):
		activeCamera = back
	else:
		activeCamera = front
	activeCamera.enabled = true
	activeCamera.visible = true


func _time_up_message():
	emit_signal("on_time_up")

func _reset_timer():
	if (timer): timer._restart_time()
