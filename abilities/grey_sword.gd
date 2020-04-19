extends Node2D

func _ready():
	$animation_player.play("swing")
	
	yield($animation_player, "animation_finished")
	
	queue_free()

func _on_hitbox_body_entered(body):
	if body.has_method("hit_by_grey_sword"):
		body.hit_by_grey_sword(get_parent().global_position)

