extends Powerup

@export var special_ammo: PackedScene

func apply_effect(player: Player):
	var old_bullet_count = player.bullet_count
	var old_bullet_cooldown = player.bullet_cooldown
	player.bullet_scene = special_ammo
	player.bullet_count = 1
	player.bullet_cooldown *= 2
	var timer = get_tree().create_timer(3.0)
	timer.connect("timeout", func(): player.bullet_scene = player.standard_ammo; \
	player.bullet_count = old_bullet_count; player.bullet_cooldown /= 2)
