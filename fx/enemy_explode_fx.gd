extends Node2D

export(bool) var play_sfx = true

func _ready():
	# print('kaboom')
	$animated_sprite.play()
	if play_sfx:
		$audio_stream_player_2d.play()

func _on_lifetime_timeout():
	queue_free()
