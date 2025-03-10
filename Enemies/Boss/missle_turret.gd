extends Turret


func _physics_process(delta: float) -> void:
	if is_instance_valid(target) and not freeze_rotation:
		look_at(target.position)
		
	time_since_firing += delta
	if time_since_firing >= bullet_cooldown:
		time_since_firing = 0
		for x in range(8):
			gun_marker.rotation = (randf() - 0.5) * 3*PI/4
			attack()
			await get_tree().create_timer(0.1).timeout
		
