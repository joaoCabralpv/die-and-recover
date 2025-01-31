extends KillArea

func body_collided(body):
	if body is Character:
		kill_player.emit(body)
