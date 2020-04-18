extends Node2D

func _ready():
	add_to_group("game_over")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):

		get_tree().quit()

func game_over():
	get_tree().quit()
