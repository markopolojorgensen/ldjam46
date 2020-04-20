extends Node2D

const payload_scene = preload("res://payload.tscn")

export(bool) var show_health_hud = false


func _ready():
	add_to_group("stage")
	if show_health_hud:
		get_tree().call_group("health_layer", "start_stage")

func start_stage():
	var inst = payload_scene.instance()
	$y_sort.call_deferred("add_child", inst)
	inst.global_position = $y_sort/start_button.global_position



