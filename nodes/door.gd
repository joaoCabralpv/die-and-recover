extends StaticBody2D

class_name Door

enum State{Open,Close,Stop}
var state:State = State.Stop

@export var speed = 3

func open():
	state=State.Open
			
func close():
	state=State.Close

func _on_button_presed():
	open()

func _on_button_released():
	close()

func _process(delta):
	if state == State.Open:
		scale.y = clamp(scale.y-(speed*delta),0,1)
	elif state == State.Close:
		scale.y = clamp(scale.y+(speed*delta),0,1)
