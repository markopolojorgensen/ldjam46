extends Node

var trauma_depletion = 0.9
var trauma = 0
var max_camera_offset = 60
var max_camera_degrees = 10


# normal time is too slow
var offset_time_factor = 2.5
var rot_time_factor = 3.5


func _ready():
	add_to_group("trauma_listener")


# affects Camera2D node position, not parent root Node2D
func shake_screen(delta):
	$trauma.set_text(str(trauma))
	
	if trauma > 0:
		# translational
		var offset = Vector2()
		offset.x = $noise_generators/x.get_noise(delta * offset_time_factor)
		offset.y = $noise_generators/y.get_noise(delta * offset_time_factor)
		offset *= max_camera_offset * pow(trauma, 3) # squared or cubed
		# not global position, this is relative to parent
		$Camera2D.set_position(offset)
		
		#rotational
		var rot = $noise_generators/rot.get_noise(delta * rot_time_factor) * max_camera_degrees * pow(trauma, 3)
		$Camera2D.set_rotation_degrees(rot)
		
		# trauma decreases linearly over time
		var new_trauma = trauma - (trauma_depletion * delta)
		trauma = clamp(new_trauma, 0, 1)

func add_trauma(amount):
	var new_trauma = trauma + amount
	trauma = clamp(new_trauma, 0, 1)

func add_limited_trauma(amount, max_new_trauma):
	var new_trauma = trauma + amount
	if new_trauma < max_new_trauma:
		trauma = new_trauma
