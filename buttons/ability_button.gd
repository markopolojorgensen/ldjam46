extends StaticBody2D

export(String,
	"payload_speed",
	"click_swing",
	"beyblade",
	"double_damage",
	"regen",
	"player_armor",
	"payload_armor",
	"burning_aura"
	) var ability = "payload_speed"

func use_random_ability():
	var index = randi() % global.abilities.keys().size()
	ability = global.abilities.keys()[index]

func _ready():
	$center_container/label.text = global.abilities[ability]["text"]
	
	$collision_shape_2d.disabled = true
	yield(get_tree().create_timer(1), "timeout")
	$collision_shape_2d.disabled = false

func _process(_delta):
	if global.ability_budget <= 0:
		queue_free()

func hit_by_grey_sword(_player):
	global.abilities[ability]["active"] = true
	global.ability_budget -= 1
	get_tree().call_group("abilities", "update_abilities")
	queue_free()
