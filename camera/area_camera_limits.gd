extends Area2D

func _ready():
	connect("body_entered", self, "entered")
	connect("body_exited", self, "exited")

func entered(_thing):
	get_tree().call_group("camera", "set_limits", get_limits())

func exited(_thing):
	get_tree().call_group("camera", "clear_limits", get_limits())

func get_limits():
	var result = {}
	
	if has_node("limit_top"):
		result["limit_top"] = $limit_top.get_global_position().y
	
	if has_node("limit_bottom"):
		result["limit_bottom"] = $limit_bottom.get_global_position().y
	
	if has_node("limit_left"):
		result["limit_left"] = $limit_left.get_global_position().x
	
	if has_node("limit_right"):
		result["limit_right"] = $limit_right.get_global_position().x
	
	return result



