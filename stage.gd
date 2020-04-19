extends Node2D

const payload_scene = preload("res://payload.tscn")

func _ready():
	add_to_group("stage")

func start_stage():
	var inst = payload_scene.instance()
	$y_sort.call_deferred("add_child", inst)
	inst.global_position = $y_sort/start_button.global_position
