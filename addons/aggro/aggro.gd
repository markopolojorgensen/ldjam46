extends Area2D

# also see http://kidscancode.org/blog/2018/03/godot3_visibility_raycasts/

# don't forget to set up collision layers appropriately
#   raycast needs to collide with scenery layer and aggroing things layer
#   I think you can have scenery and aggroing things on the same layer, but I've not tested it
# don't forget to add triggers_aggro() to bodies you want to trigger aggro
# don't forget to add a shape for the aggro and set the raycast path


signal aggro(entity)
signal aggro_lost(entity)

# can't instantiate scenes via plugin, so you have to supply your own raycast node
# it's fine to add it as a child of the aggro node.
export(NodePath) var raycast_path
onready var raycast = get_node(raycast_path)

# everything within range, regardless of sight
var potential_targets = []

# Todo: support aggroing multiple targets!
var target
var aggro_active = false

func _ready():
	connect("body_entered", self, "body_entered")
	connect("body_exited", self, "body_exited")

func _process(delta):
	# hack to force area to recognize static bodies
	position = position
	
	if target != null:
		var target_in_sight = can_see(target)
		if not aggro_active and target_in_sight:
			emit_signal("aggro", target)
			aggro_active = true
		elif aggro_active and not target_in_sight:
			emit_signal("aggro_lost", target)
			aggro_active = false
	
	if not aggro_active:
		for thing in potential_targets:
			if can_see(thing):
				target = thing

func can_see(thing):
	var aggro_point = thing.global_position
	if thing.has_node("aggro_point"):
		aggro_point = thing.get_node("aggro_point").global_position
	
	raycast.cast_to = aggro_point - global_position
	raycast.force_raycast_update()
	
	return raycast.is_colliding() and raycast.get_collider() == thing

func body_entered(body):
	if body.has_method("triggers_aggro") and body.triggers_aggro():
		potential_targets.append(body)

func body_exited(body):
	if body.has_method("triggers_aggro") and body.triggers_aggro():
		if potential_targets.has(body):
			potential_targets.remove(potential_targets.find(body))
		
		if target == body:
			if aggro_active:
				emit_signal("aggro_lost", target)
				aggro_active = false
			target = null




