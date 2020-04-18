extends RigidBody2D

var health = 10

var current_target_ref : WeakRef

const small_red_sword_scene = preload("res://abilities/small_red_sword.tscn")
const striking_distance = 80
const sword_offset = 15

func _ready():
	$animated_sprite.play()
	add_to_group("enemy")

func _integrate_forces(state):
	$movement.do_movement(state)

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
		direction = current_target_ref.get_ref().global_position - global_position
	return direction

func _on_aggro_aggro(entity):
	current_target_ref = weakref(entity)

func _on_aggro_aggro_lost(_entity):
	current_target_ref = null

func hit_by_grey_sword():
	health -= 5
	if health <= 0:
		queue_free()


