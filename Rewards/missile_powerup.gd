extends Powerup

@export var special_ammo: PackedScene


func apply_effect(player: Player):
	player.bullet_scene = special_ammo
	var timer = get_tree().create_timer(5.0)
	timer.connect("timeout", func(): player.bullet_scene = player.standard_ammo)
