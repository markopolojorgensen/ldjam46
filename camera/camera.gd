extends Node2D


func _ready():
	add_to_group("camera")

func set_limits(limits):
	$focus_limiter.set_limits(limits)

func clear_limits(limits):
	$focus_limiter.clear_limits(limits)

