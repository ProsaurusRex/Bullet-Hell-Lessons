class_name Medpack
extends Powerup

func apply_effect(player: Player):
	player.take_damage(-1)
