class_name Weapon
extends Area2D

@onready var weapon_sprite: Sprite2D = $WeaponSprite

var active : bool = false
var weapon_scaler : float = 10

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _flip_weapon() -> void:
	scale.x *= -1

func _reset_weapon() -> void:
	scale = Vector2.ONE / weapon_scaler

func _activate() -> void:
	active = true
	visible = true
	scale *= weapon_scaler
	
func _deactivate() -> void:
	active = false
	visible = false
	scale /= weapon_scaler
