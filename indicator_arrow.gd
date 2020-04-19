extends AnimatedSprite

func _process(_delta):
	var players = get_tree().get_nodes_in_group("player")
	var player
	if players.size() > 0:
		player = players.front()
	
	var hearts = get_tree().get_nodes_in_group("inferno_heart")
	var heart
	if hearts.size() > 0:
		heart = hearts.front()
	
	if heart and is_visible_in_tree():
		var weight = 1.0 - (heart.health / 100.0)
		var multiplier = lerp(1.0, 4.0, weight)
		frames.set_animation_speed("default", 20 * multiplier)
	
	if player and heart and not heart.on_screen():
		play()
		show()
		
		var direction = heart.global_position - player.global_position
		global_position = player.global_position + direction.normalized() * 300
		rotation = direction.angle()
		# var target = player.get_camera().global_position
		# global_position.x = clamp(global_position.x, target.x - 560, target.x + 560)
		# global_position.y = clamp(global_position.y, target.y - 315, target.y + 315)
	else:
		stop()
		hide()
	
	
	
