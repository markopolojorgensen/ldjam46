extends Node2D

func _ready():
	add_to_group("game_over")
	add_to_group("goal")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func game_over():
	get_tree().quit()

func goal():
	$music.stop()
	yield(get_tree().create_timer(2.0), "timeout")
	$wind/tween.interpolate_property($wind, "volume_db", -30, $wind.volume_db, 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$wind/tween.start()
	$wind.play()



