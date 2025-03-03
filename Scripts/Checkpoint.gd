class_name Checkpoint

extends Area2D

var checked : bool = false


func _on_body_entered(body: Node2D) -> void:
	if (body is Player && !checked):
		checked = true
		body._sent_spawn_point(position)
