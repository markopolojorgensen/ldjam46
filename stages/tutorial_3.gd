extends Node2D

func _ready():
	# to make health appear
	get_tree().call_group("stage", "start_stage")
	
