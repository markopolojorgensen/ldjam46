extends Node2D

func _ready():
	$animation_player.play("swing")
	
	yield($animation_player, "animation_finished")
	
	queue_free()


