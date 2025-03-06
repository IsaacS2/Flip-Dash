class_name CameraManager

extends Node2D

signal on_flip
signal on_time_up

@onready var front: Camera2D = $Front
@onready var back: Camera2D = $Back
@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer

var activeCamera: Camera2D
var cameraZoom: int = 1
var flipBuffer: float
var flipBufferTime: float = 0.25


func _ready() -> void:
	activeCamera = front
	timer.time_up.connect(_time_up_message)

func _process(delta: float) -> void:
	position.x = player.position.x
	
	flipBuffer = max(0, flipBuffer - delta)
	
	if (Input.is_action_just_pressed("Flip") && flipBuffer <= 0): # check if game isn't paused atm
		flipBuffer = flipBufferTime
		emit_signal("on_flip")

func _flip_camera() -> void:
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
	flipBuffer = 0

func _reset_timer():
	if (timer): timer._restart_time()
