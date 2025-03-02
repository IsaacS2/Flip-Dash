extends Node2D
var activeCamera: Camera2D
@onready var front: Camera2D = $Front
@onready var back: Camera2D = $Back
@onready var player: CharacterBody2D = %Player

func _ready() -> void:
	activeCamera = front
	print("check")

func _process(delta: float) -> void:
	position.x = player.position.x
	
	if (Input.is_action_just_pressed("Flip")):
		print("flipping camera")
		activeCamera.enabled = false
		if (activeCamera == front):
			activeCamera = back
		else:
			activeCamera = front
		activeCamera.enabled = true
