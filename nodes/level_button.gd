extends Area2D

class_name LevelButton

signal presed
signal released

var characters_colliding: int = 0
#These two function (_on_area_2d_body_entered and _on_area_2d_body_exited) keep track of the characters coliding in the button
func _on_body_entered(body):
	if body is Character:
		characters_colliding+=1
		if characters_colliding == 1: # Presses the buton only 1 character is in the button (there were no characters in the buton before)
			presed.emit()

func _on_body_exited(body):
	if body is Character:
		characters_colliding-=1
		if characters_colliding == 0: # Releases the button if no character are in the button
			released.emit()
