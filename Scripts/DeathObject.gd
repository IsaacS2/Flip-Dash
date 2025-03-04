class_name Death
extends Area2D

var danger : bool = true

func _on_body_entered(body: Node2D) -> void:
	if (body is Player && danger):
		body._on_death()

func _on_area_entered(area: Area2D) -> void:
	if (area is Weapon && area.active):
		danger = false
		get_parent().visible = false

func _reenable() -> void:
	get_parent().visible = true
	danger = true
