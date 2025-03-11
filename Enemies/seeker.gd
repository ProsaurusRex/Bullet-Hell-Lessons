extends Enemy

@export var target: Node2D
var turn_speed = PI/4

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		var target_direction = position.direction_to(target.position)
		direction = direction.rotated(transform.x.cross(target_direction) * turn_speed * delta)
		#if transform.x.cross(target_direction) > 0:
			#direction = direction.rotated(turn_speed * delta)
		#else:
			#direction = direction.rotated(-turn_speed * delta)
	super._physics_process(delta)


func set_target(new_target):
	if is_instance_valid(new_target):
		target = new_target
