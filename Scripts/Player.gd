class_name Player

extends CharacterBody2D

const SPEED = 250.0
const JUMP_VELOCITY = -400.0

@onready var player_sprite: PlayerSprite = $PlayerSprite

var velocityStorage : Vector2
var frozen : bool = false
var direction : int = 1
var jumpBuffer : float
var jumpBufferTime : float = 0.09

func _process(delta: float) -> void:
	if (jumpBuffer > 0):
		jumpBuffer -= delta


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (!frozen):
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		elif (jumpBuffer > 0):
			_jump()

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if (is_on_floor() && !frozen):
			_jump()
		else:
			jumpBuffer = jumpBufferTime

	# Handle horizontal movement
	if (!frozen):
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


func _jump():
	velocity.y = JUMP_VELOCITY
	jumpBuffer = 0
