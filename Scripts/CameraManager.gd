extends Node
var activeCamera: Camera2D
@onready var front: Camera2D = $Front
@onready var back: Camera2D = $Back

func _ready() -> void:
	activeCamera = front

func _process(delta: float) -> void:
	if (Input.is_action_just_pressed("Flip")):
		print("flipping camera")
		activeCamera.enabled = false
		if (activeCamera == front):
			activeCamera = back
		else:
			activeCamera = front
		activeCamera.enabled = true
