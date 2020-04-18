extends RigidBody2D

const grey_sword_scene = preload("res://abilities/grey_sword.tscn")
const sword_offset = 45

func _ready():
	$animated_sprite.play()

func _integrate_forces(state):
	$movement.do_movement(state)

func _unhandled_input(event):
	if event.is_action_pressed("primary_ability"):
		var inst = grey_sword_scene.instance()
		add_child(inst)
		var swing_direction : Vector2 = get_global_mouse_position() - global_position
		inst.rotation = swing_direction.angle()
		inst.position = swing_direction.normalized() * sword_offset

func triggers_aggro():
	return true

func hit_by_small_red_sword():
	# print("ow")
	pass

