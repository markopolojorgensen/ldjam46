extends StaticBody2D

export(bool) var is_goal = false
export(bool) var play_sfx = true

func _on_aggro_aggro(_entity):
	if play_sfx:
		$checkpoint_ding.play()
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()

func triggers_aggro():
	return true
