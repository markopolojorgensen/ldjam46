extends Area2D

# also see http://kidscancode.org/blog/2018/03/godot3_visibility_raycasts/

# don't forget to set up collision layers appropriately
#   raycast needs to collide with scenery layer and aggroing things layer
#   I think you can have scenery and aggroing things on the same layer, but I've not tested it
# don't forget to add triggers_aggro() to bodies you want to trigger aggro
# don't forget to add a shape for the aggro and set the raycast path
# don't forget to enable the raycast

signal aggro(entity)
signal aggro_lost(entity)

# can't instantiate scenes via plugin, so you have to supply your own raycast node
# it's fine to add it as a child of the aggro node.
export(NodePath) var raycast_path
onready var raycast_ref = weakref(get_node(raycast_path))

# everything within range, regardless of sight
var potential_target_refs = []

# Todo: support aggroing multiple targets!
var target_ref
var aggro_active = false

func _ready():
	connect("body_entered", self, "body_entered")
	connect("body_exited", self, "body_exited")

func _process(delta):
	# hack to force area to recognize static bodies
	position = position
	
	if target_ref and target_ref.get_ref():
		var target = target_ref.get_ref()
		var target_in_sight = can_see(target)
		if not aggro_active and target_in_sight:
			emit_signal("aggro", target)
			aggro_active = true
		elif aggro_active and not target_in_sight:
			emit_signal("aggro_lost", target)
			aggro_active = false
	
	if not aggro_active:
		for thing_ref in potential_target_refs:
			if thing_ref and thing_ref.get_ref():
				var thing = thing_ref.get_ref()
				if can_see(thing):
					target_ref = thing_ref

func can_see(thing):
	var aggro_point = thing.global_position
	if thing.has_node("aggro_point"):
		aggro_point = thing.get_node("aggro_point").global_position
	
	if raycast_ref and raycast_ref.get_ref():
		var raycast = raycast_ref.get_ref()
		raycast.cast_to = aggro_point - global_position
		raycast.force_raycast_update()
		
		return raycast.is_colliding() and raycast.get_collider() == thing
	else:
		return false

func body_entered(body):
	if body.has_method("triggers_aggro") and body.triggers_aggro():
		potential_target_refs.append(weakref(body))

func body_exited(body):
	if body.has_method("triggers_aggro") and body.triggers_aggro():
		for ref in potential_target_refs:
			if ref and ref.get_ref() == body:
				potential_target_refs.erase(ref)
		
		if target_ref and target_ref.get_ref() == body:
			if aggro_active:
				emit_signal("aggro_lost", target_ref.get_ref())
				aggro_active = false
			target_ref = null

func potential_targets_has(body):
	return false


