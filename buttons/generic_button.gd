extends StaticBody2D

export(String, "payload_speed") var ability = "payload_speed"

func _ready():
	$center_container/label.text = global.abilities[ability]["text"]

func hit_by_grey_sword(_player):
	global.abilities[ability]["active"] = true
	queue_free()
