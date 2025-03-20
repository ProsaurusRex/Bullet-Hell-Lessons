extends Powerup


func apply_effect(player: Player):
	player.bullet_cooldown /= 2
	var timer = get_tree().create_timer(5.0)
	timer.connect("timeout", func(): player.bullet_cooldown *= 2)
