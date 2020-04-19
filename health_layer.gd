extends CanvasLayer

func _process(_delta):
	$margin_container/texture_progress.value = 100 - global.player_health
	$health_debug.text = str(global.player_health)
