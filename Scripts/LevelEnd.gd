extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		var _root = get_tree().root
		print("touched player")
		if (_root.get_child(0) is GameManager):
			print("got gamemanager")
			_root.get_child(0)._to_next_scene()
