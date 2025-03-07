class_name Background

extends TextureRect

@onready var cameras: CameraManager = $"../Cameras"
var originalModulate : Color
var direction : int = 1

func _ready() -> void:
	originalModulate = modulate
	if (cameras): 
		#cameras.on_death.connect(_reset_for_checkpoint)
		#cameras.on_time_up.connect(_reset_level)
		cameras.on_flip.connect(_on_cameras_flip)
	_reset_background()

func _on_cameras_flip():
	direction *= -1
	if (direction == 1):
		modulate = originalModulate * Color.RED
	else:
		modulate = originalModulate * Color.BLUE

func _reset_background():
	direction = 1
	modulate = originalModulate * Color.RED
