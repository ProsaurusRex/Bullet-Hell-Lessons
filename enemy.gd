class_name Enemy
extends Fighter


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y += speed * delta
	# Clamp position here
	
	time_since_firing += delta
	if time_since_firing >= bullet_cooldown:
		time_since_firing = 0
		attack()
