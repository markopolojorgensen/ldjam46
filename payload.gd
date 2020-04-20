extends RigidBody2D

var health = 100

var next_waypoint_ref : WeakRef

func _ready():
	$animated_sprite.play()
	add_to_group("inferno_heart")
	add_to_group("game_over")
	add_to_group("abilities")
	add_to_group("goal")
	
	update_abilities()

func update_abilities():
	if global.abilities["payload_speed"]["active"]:
		$movement.max_speed = 400

func _integrate_forces(state):
	$movement.do_movement(state)

func _process(delta):
	# burning aura
	if global.abilities["burning_aura"]["active"]:
		for body in $burning_aura.get_overlapping_bodies():
			if body.has_method("burn"):
				body.burn(delta)

func goal():
	$animation_player.play("fade_out")
	$collision_shape_2d.disabled = true
	
	$krakow.play()
	yield(get_tree().create_timer(1.5), "timeout")
	$fanfare.play()
	

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
	if global.abilities["payload_armor"]["active"]:
		global.player_health -= 0.5
	else:
		global.player_health -= 1
	$ouch.play()
	$heart_ouch.play()

func on_screen():
	return $visibility_notifier_2d.is_on_screen()

func game_over():
	queue_free()














