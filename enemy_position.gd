extends Node2D

export(String, "small", "medium", "boss") var enemy_type = "small"
export(String, "easy", "medium", "hard") var difficulty = "easy"

const enemy_scene = preload("res://enemy/small_red_enemy.tscn")
const medium_enemy_scene = preload("res://enemy/medium_enemy.tscn")
const boss_enemy_scene = preload("res://enemy/boss_enemy.tscn")

func _ready():
	add_to_group("stage")

func start_stage():
	var inst
	if enemy_type == "small":
		inst = enemy_scene.instance()
	elif enemy_type == "medium":
		inst = medium_enemy_scene.instance()
	elif enemy_type == "boss":
		inst = boss_enemy_scene.instance()
	inst.difficulty = difficulty
	get_parent().add_child(inst)
	inst.global_position = global_position

