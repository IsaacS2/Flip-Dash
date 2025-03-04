class_name Death

extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		body._on_death()

func _on_area_entered(area: Area2D) -> void:
	print("item enters")
	if (area is Weapon && area.active):
		queue_free()
		get_parent().queue_free()
