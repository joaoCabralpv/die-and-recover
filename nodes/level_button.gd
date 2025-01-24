extends Area2D
class_name LevelButton

signal change_state(state:Types.DoorState)

var characters_colliding: int = 0
#These two function (_on_area_2d_body_entered and _on_area_2d_body_exited) keep track of the characters coliding in the button
func _on_body_entered(body):
	if body is CollisionObject2D:
		characters_colliding+=1
		if characters_colliding == 1: # Presses the buton only 1 character is in the button (there were no characters in the buton before)
			change_state.emit(Types.DoorState.Open)

func _on_body_exited(body):
	if body is CollisionObject2D:
		characters_colliding-=1
		if characters_colliding == 0: # Releases the button if no character are in the button
			change_state.emit(Types.DoorState.Close)
