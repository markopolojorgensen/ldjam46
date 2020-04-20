extends Button

func _on_tutorial_button_pressed():
	get_tree().call_group("menu", "start_tutorial")
