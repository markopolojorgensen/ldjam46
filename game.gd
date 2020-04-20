extends Node2D

var menu_scene = preload("res://stages/menu.tscn")

var stage_progression = []
var current_stage

var tutorial_stage_progression = [
	preload("res://stages/tutorial_1.tscn"),
	preload("res://stages/tutorial_2.tscn"),
	preload("res://stages/tutorial_3.tscn"),
]

var main_stage_progression = [
	preload("res://stages/stage_1.tscn"),
	preload("res://stages/stage_2.tscn"),
	preload("res://stages/stage_3.tscn"),
	preload("res://stages/stage_4.tscn"),
]

var testing_stage_progression = [
	preload("res://stages/testing_area.tscn")
]


func _ready():
	global.reset()
	
	add_to_group("game_over")
	add_to_group("goal")
	add_to_group("stage")
	add_to_group("stage_manager")
	add_to_group("menu")
	
	advance_stage()
	
	get_tree().call_group("goal", "goal")

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func game_over():
	music_to_wind()
	
	yield(get_tree().create_timer(5.0), "timeout")
	stage_progression = [menu_scene]
	advance_stage()

func goal():
	music_to_wind()

func music_to_wind():
	$music.stop()
	yield(get_tree().create_timer(2.0), "timeout")
	$wind/tween.interpolate_property($wind, "volume_db", -30, $wind.volume_db, 5.0, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$wind/tween.start()
	$wind.play()

func start_stage():
	$wind.stop()
	$music.play()
	global.player_health = 100

func finish_stage():
	advance_stage()

func start_tutorial():
	stage_progression = tutorial_stage_progression.duplicate()
	advance_stage()

func start_game():
	global.reset()
	stage_progression = main_stage_progression.duplicate()
	advance_stage()

func start_testing():
	global.ability_budget = 100
	stage_progression = testing_stage_progression.duplicate()
	advance_stage()

func advance_stage():
	if not in_the_middle_of_a_transition():
		$animation_player.play("transition")
		yield(get_tree().create_timer(0.65), "timeout")
		if current_stage:
			current_stage.queue_free()
		var next_stage_scene = stage_progression.pop_front()
		
		if next_stage_scene:
			current_stage = next_stage_scene.instance()
		else:
			current_stage = menu_scene.instance()
		
		add_child(current_stage)

func in_the_middle_of_a_transition():
	return $animation_player.is_playing()
