extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		_next_scene()

func _next_scene():
	var _root = get_tree().root
	if (_root.get_child(0) is GameManager):
		_root.get_child(0)._to_next_scene()
