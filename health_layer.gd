extends CanvasLayer

func _ready():
	add_to_group("stage")
	add_to_group("health_layer")
	
	$margin_container.hide()
	$health_debug.hide()
	$margin_container2.hide()

func _process(delta):
	$margin_container/texture_progress.value = 100 - global.player_health
	$health_debug.text = "%.0f" % global.player_health
	
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		var player = players.front()
		if global.abilities["regen"]["active"] and player.linear_velocity.length() < 20:
			global.player_health = min(global.player_health + delta * 5, 100)

func start_stage():
	$margin_container.show()
	$health_debug.show()
	$margin_container2.show()

func finish_stage():
	$margin_container.hide()
	$health_debug.hide()



