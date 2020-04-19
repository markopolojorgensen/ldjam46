extends Node2D

const enemy_scene = preload("res://enemy/small_red_enemy.tscn")

func _ready():
	add_to_group("stage")

func start_stage():
	var inst = enemy_scene.instance()
	get_parent().add_child(inst)
	inst.global_position = global_position

