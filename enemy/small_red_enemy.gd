extends RigidBody2D

var health = 10

var current_target_ref : WeakRef

const small_red_sword_scene = preload("res://abilities/small_red_sword.tscn")
const striking_distance = 80
const sword_offset = 15

const knockback = 1000
var pending_impulse = Vector2()

const explode_fx = preload("res://fx/enemy_explode_fx.tscn")

func _ready():
	$animated_sprite.play()
	$animated_sprite.frame = rand_range(0, 100)
	add_to_group("enemy")
	add_to_group("goal")

func _integrate_forces(state):
	$movement.do_movement(state)
	state.apply_central_impulse(pending_impulse)
	pending_impulse = Vector2()

func _process(_delta):
	# maybe attack target
	if $attack_cooldown.is_stopped():
		if current_target_ref and current_target_ref.get_ref():
			if $aggro_raycast.cast_to.length() < striking_distance:
				$attack_cooldown.start()
				var inst = small_red_sword_scene.instance()
				add_child(inst)
				inst.position = $aggro_raycast.cast_to.normalized() * sword_offset
				inst.rotation = $aggro_raycast.cast_to.angle()
	
	# update health hud
	$health_hud.value = health
	if health >= 10:
		$health_hud.hide()
	else:
		$health_hud.show()

func get_intended_direction():
	var direction = Vector2()
	if current_target_ref and current_target_ref.get_ref():
		var target = current_target_ref.get_ref()
		var target_position = target.global_position + (target.linear_velocity.normalized() * 80)
		direction = target_position - global_position
	return direction

func _on_aggro_aggro(entity):
	current_target_ref = weakref(entity)

func _on_aggro_aggro_lost(_entity):
	current_target_ref = null

func hit_by_grey_sword(player_position):
	$ouch.play()
	health -= 5
	if health <= 0:
		explode(true)
	
	# knockback
	var direction = global_position - player_position
	
	pending_impulse += direction.normalized() * knockback

func explode(sfx):
	var inst = explode_fx.instance()
	inst.play_sfx = sfx
	inst.global_position = global_position
	get_parent().add_child(inst)
	
	queue_free()

# called when goal waypoint is reached
func goal():
	# don't play explode sounds when all exploding at once
	explode(false)
