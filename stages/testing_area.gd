extends Button

func _on_testing_area_pressed():
	get_tree().call_group("menu", "start_testing")
