extends Node

var player_health = 100 setget set_health

func reset():
	player_health = 100

func set_health(new_value):
	player_health = new_value
	if player_health <= 0:
		get_tree().call_group("game_over", "game_over")
