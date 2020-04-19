extends RigidBody2D

var health = 100

var next_waypoint_ref : WeakRef
var won = false

func _ready():
	$animated_sprite.play()
	add_to_group("inferno_heart")

func _integrate_forces(state):
	$movement.do_movement(state)

func _process(_delta):
	# check for goal
	if next_waypoint_ref and next_waypoint_ref.get_ref() and "is_goal" in next_waypoint_ref.get_ref() and next_waypoint_ref.get_ref().is_goal:
		# we have a goal
		var here_to_goal = next_waypoint_ref.get_ref().global_position - global_position
		if here_to_goal.length() < 150 and not won:
			won = true
			get_tree().call_group("goal", "goal")
			$krakow.play()
			yield(get_tree().create_timer(1.5), "timeout")
			$fanfare.play()
			# print("gooooooaaaaaal")

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
	global.player_health -= 1
	$ouch.play()
	$heart_ouch.play()

func on_screen():
	return $visibility_notifier_2d.is_on_screen()















