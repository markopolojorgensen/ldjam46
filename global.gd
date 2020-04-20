extends Node

var player_health = 100.0 setget set_health

var abilities : Dictionary

var ability_budget = 0

const abilities_prototype = {
	"payload_speed": {
		"text": "Increase Inferno Heart movement speed",
		"active": false,
	},
	"click_swing": {
		"text": "Swing as fast as you can click",
		"active": false,
	},
	"beyblade": {
		"text": "Two weapons are better than one",
		"active": false,
	},
	"double_damage": {
		"text": "Double Damage",
		"active": false,
	},
	"regen": {
		"text": "Slowly regain health when standing still",
		"active": false,
	},
	"player_armor": {
		"text": "You take half damage",
		"active": false,
	},
	"payload_armor": {
		"text": "Inferno Heart takes half damage",
		"active": false,
	},
	"burning_aura": {
		"text": "Inferno Heart damages nearby enemies",
		"active": false,
	},
}

func get_random_abilites(num):
	randomize()
	var ability_names = global.abilities.keys().duplicate()
	ability_names.shuffle()
	return ability_names.slice(0, num-1)

func reset():
	player_health = 100
	abilities = abilities_prototype.duplicate()
	ability_budget = 0



func set_health(new_value):
	player_health = new_value
	if player_health <= 0:
		get_tree().call_group("game_over", "game_over")
