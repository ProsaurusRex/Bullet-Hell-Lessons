extends Powerup

func apply_effect(player: Player):
	if player.bullet_count < player.MAX_BULLET_COUNT:
		player.bullet_count += 1
