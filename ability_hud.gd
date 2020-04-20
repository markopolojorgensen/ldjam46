extends VBoxContainer

func _ready():
	add_to_group("abilities")

func update_abilities():
	for ability_name in global.abilities.keys():
		if global.abilities[ability_name]["active"]:
			get_node(ability_name).text = global.abilities[ability_name]["text"]
			get_node(ability_name).show()
		else:
			get_node(ability_name).hide()
