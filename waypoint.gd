extends StaticBody2D

export(bool) var is_goal = false

func _on_aggro_aggro(_entity):
	queue_free()

func triggers_aggro():
	return true
