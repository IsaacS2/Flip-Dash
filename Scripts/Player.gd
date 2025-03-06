class_name Player
extends CharacterBody2D

signal on_death

const SPEED = 12000.0
const JUMP_VELOCITY = -400.0

@onready var player_sprite: PlayerSprite = $PlayerSprite
@onready var weapon_hitbox: Weapon = $WeaponHitbox

var velocityStorage : Vector2
var frozen : bool = false
var direction : int = 1
var jumpBuffer : float
var jumpBufferTime : float = 0.09
var groundBuffer : float
var groundBufferTime : float = 0.09
var attackBuffer : float
var attackBufferTime : float = 0.4
var attackEndLag : float = 0.1
var spawnPoint : Vector2 = Vector2.ZERO

func _ready() -> void:
	_reset_weapon()

func _process(delta: float) -> void:
	if (jumpBuffer > 0):
		jumpBuffer -= delta
	if (groundBuffer > 0):
		groundBuffer -= delta
	if (!frozen && Input.is_action_just_pressed("Attack") && attackBuffer <= 0):
		_attack()
	if (attackBuffer > 0 && !frozen):
		attackBuffer -= delta
		if (attackBuffer < attackEndLag && weapon_hitbox.active):
			player_sprite.animation = "Walk"
			player_sprite.play()
			_hide_weapon()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if (!frozen):
		if not is_on_floor():
			velocity += get_gravity() * delta
		
		else:
			if (jumpBuffer > 0):
				_jump()
			else:
				groundBuffer = groundBufferTime

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if ((is_on_floor() || groundBuffer > 0) && !frozen):
			_jump()
		else:
			jumpBuffer = jumpBufferTime

	if (!frozen):
		velocity.x = direction * SPEED * delta
		move_and_slide()

func _flip_velocity():
	if (weapon_hitbox): weapon_hitbox._flip_weapon()
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
	groundBuffer = 0
	jumpBuffer = 0

func _on_death():
	emit_signal("on_death")

func _sent_spawn_point(location : Vector2):
	spawnPoint = location

func _reposition():
	_reset_weapon()
	position = spawnPoint

func _attack():
	weapon_hitbox._activate()
	player_sprite.animation = "Bite"
	attackBuffer = attackBufferTime + attackEndLag

func _reset_weapon():
	_hide_weapon()
	weapon_hitbox._reset_weapon()

func _hide_weapon():
	weapon_hitbox._deactivate()
