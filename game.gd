extends Node2D

func _ready():
	pass # Replace with function body.

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):

		get_tree().quit()
