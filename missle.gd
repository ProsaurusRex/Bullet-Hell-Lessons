extends Bullet

var target: Node2D

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		pass
	super._physics_process(delta)
