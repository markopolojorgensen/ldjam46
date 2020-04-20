extends Button

func _on_play_button_pressed():
	get_tree().call_group("menu", "start_game")
