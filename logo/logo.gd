extends Node2D

func play_logo():
	$CanvasLayer/MarginContainer/CenterContainer/Control/node_2d/AnimatedSprite.play()
	$AudioStreamPlayer.play()
	
	yield(get_tree().create_timer(1.25), "timeout")
	
	$animation_player.play("fade_out")

