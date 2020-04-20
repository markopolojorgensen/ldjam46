extends StaticBody2D

export(bool) var is_goal = false
export(bool) var play_sfx = true
export(bool) var spawn_abilities = false

const continue_button = preload("res://buttons/finish_stage_button.tscn")
const ability_button = preload("res://buttons/ability_button.tscn")

func _on_aggro_aggro(_entity):
	if play_sfx:
		$checkpoint_ding.play()
	
	if is_goal:
		var inst = continue_button.instance()
		inst.global_position = $continue_button.global_position
		get_parent().add_child(inst)
		inst.global_position = $continue_button.global_position
		
		# abilities
		if spawn_abilities:
			spawn_abilities = false
			global.ability_budget += 1
			var abilities : Array = global.get_random_abilites(2)
			print(abilities)
			for button_position in $ability_button_positions.get_children():
				var ab_button = ability_button.instance()
				ab_button.ability = abilities.pop_front()
				add_child(ab_button)
				ab_button.global_position = button_position.global_position
	else:
		$collision_shape_2d.disabled = true
		
		$tween.interpolate_property(self, "modulate", Color.white, Color(1,1,1,0), 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$tween.start()
		
		yield(get_tree().create_timer(0.5), "timeout")
		queue_free()

func triggers_aggro():
	return true
