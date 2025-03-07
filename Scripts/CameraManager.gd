class_name CameraManager

extends Node2D

signal on_death
signal on_flip
signal on_time_up

@onready var front: Camera2D = $Front
@onready var back: Camera2D = $Back
@onready var player: CharacterBody2D = %Player
@onready var timer: Timer = $Timer
#@onready var shark_background: Background = %SharkBackground

var activeCamera: Camera2D
var cameraZoom: int = 1
var flipBuffer: float
var flipBufferTime: float = 0.25
var timeUp = false
var flippable = true

func _ready() -> void:
	activeCamera = front
	if (timer): timer.time_up.connect(_time_up_message)
	if (player): 
		player.on_death_contact.connect(_disable_flip)
		player.on_death.connect(_enable_flip)

func _process(delta: float) -> void:
	position.x = player.position.x
	flipBuffer = max(0, flipBuffer - delta)
	
	# check if game isn't paused atm
	if (Input.is_action_just_pressed("Flip") && flipBuffer <= 0 && flippable):
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

func _enable_flip() -> void:
	if (timeUp): 
		emit_signal("on_time_up")
		timeUp = false
	else:
		emit_signal("on_death")
	flippable = true
	flipBuffer = 0

func _disable_flip() -> void:
	flippable = false

func _time_up_message():
	timeUp = true
	flippable = false
	player._on_death()

func _reset_timer():
	if (timer): timer._restart_time()
