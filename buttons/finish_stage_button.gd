extends StaticBody2D

func _ready():
	$collision_shape_2d.disabled = true
	yield(get_tree().create_timer(1), "timeout")
	$collision_shape_2d.disabled = false

func hit_by_grey_sword(_player):
	get_tree().call_group("stage", "finish_stage")
	queue_free()
