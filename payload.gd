extends RigidBody2D

var health = 100

var next_waypoint_ref : WeakRef

func _ready():
	$animated_sprite.play()

func _integrate_forces(state):
	$movement.do_movement(state)

func _process(_delta):
	# update health hud
	$health_layer/margin_container/texture_progress.value = 100 - health
	$health_layer/health_debug.text = str(health)
	
	# check for goal
	if next_waypoint_ref and next_waypoint_ref.get_ref() and "is_goal" in next_waypoint_ref.get_ref() and next_waypoint_ref.get_ref().is_goal:
		# we have a goal
		var here_to_goal = next_waypoint_ref.get_ref().global_position - global_position
		if here_to_goal.length() < 150:
			print("gooooooaaaaaal")

func get_intended_direction():
	var direction = Vector2()
	if next_waypoint_ref and next_waypoint_ref.get_ref():
		direction = next_waypoint_ref.get_ref().global_position - global_position
	return direction

func _on_waypoint_aggro_aggro(entity):
	next_waypoint_ref = weakref(entity)

func triggers_aggro():
	return true

func hit_by_small_red_sword():
	health -= 1
	if health <= 0:
		get_tree().call_group("game_over", "game_over")

















