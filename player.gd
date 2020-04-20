extends RigidBody2D

const grey_sword_scene = preload("res://abilities/grey_sword.tscn")
const sword_offset = 45

var dead = false

func _ready():
	$animated_sprite.play()
	add_to_group("player")
	add_to_group("game_over")
	add_to_group("abilities")


func update_abilities():
	if global.abilities["click_swing"]["active"]:
		$sword_cooldown.wait_time = 0.0001

func _integrate_forces(state):
	if not dead:
		$movement.do_movement(state)

func _unhandled_input(event):
	if event.is_action_pressed("primary_ability") and not dead:
		get_tree().set_input_as_handled()
		if $sword_cooldown.is_stopped():
			$sword_cooldown.start()
			var inst = grey_sword_scene.instance()
			add_child(inst)
			var swing_direction : Vector2 = get_global_mouse_position() - global_position
			inst.rotation = swing_direction.angle()
			inst.position = swing_direction.normalized() * sword_offset
			
			if global.abilities["beyblade"]["active"]:
				inst = grey_sword_scene.instance()
				add_child(inst)
				swing_direction = (get_global_mouse_position() - global_position).rotated(PI)
				inst.rotation = swing_direction.angle()
				inst.position = swing_direction.normalized() * sword_offset
				
	

func triggers_aggro():
	return true

func hit_by_small_red_sword():
	if global.abilities["player_armor"]["active"]:
		global.player_health -= 0.5
	else:
		global.player_health -= 1
	$ouch.play()

func get_camera():
	return $camera_2d

func game_over():
	$collision_shape_2d.disabled = true
	$animated_sprite.hide()
	dead = true
