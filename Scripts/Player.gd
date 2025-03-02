class_name Player

extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@onready var player_sprite: PlayerSprite = $PlayerSprite

var velocityStorage : Vector2
var frozen : bool = false
var direction : int = 1

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (!frozen):
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		velocity.x = direction * SPEED
	
	move_and_slide()

func _flip_velocity():
	direction *= -1
	if (player_sprite): player_sprite._flip_sprite()
	velocityStorage = velocity
	velocity = Vector2.ZERO
	frozen = true

func _return_velocity():
	velocity = velocityStorage
	frozen = false
