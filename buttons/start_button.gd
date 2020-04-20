extends StaticBody2D

func hit_by_grey_sword(_player):
	get_tree().call_group("stage", "start_stage")
	queue_free()
