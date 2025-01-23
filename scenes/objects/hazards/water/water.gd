extends KillArea

func body_collided(body):
	if body is Character and body.name=="Firey":
		kill_player.emit(body)
