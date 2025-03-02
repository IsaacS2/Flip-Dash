class_name CameraManager

extends Node2D

signal on_flip

var activeCamera: Camera2D
@onready var front: Camera2D = $Front
@onready var back: Camera2D = $Back
@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	activeCamera = front

func _process(delta: float) -> void:
	position.x = player.position.x
	
	if (Input.is_action_just_pressed("Flip")): # check if game isn't paused atm
		emit_signal("on_flip")

func _flip_camera() -> void:
	print("flipping camera")
	activeCamera.enabled = false
	if (activeCamera == front):
		activeCamera = back
	else:
		activeCamera = front
	activeCamera.enabled = true
