class_name Checkpoint

extends Area2D

var checked : bool = false
@onready var checkpoint_sprite: Sprite2D = $CheckpointSprite


func _on_body_entered(body: Node2D) -> void:
	if (body is Player && !checked):
		print("checkpoint!")
		checked = true
		body._sent_spawn_point(position)
		checkpoint_sprite.frame_coords.x += 1


func _reset_checkpoint():
	checked = false
	if (checkpoint_sprite.frame_coords.x > 0): checkpoint_sprite.frame_coords.x = 0
