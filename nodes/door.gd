extends StaticBody2D

class_name Door

enum State{Open,Close}
var state:State = State.Close

@export var speed = 3

func open():
	state=State.Open
			
func close():
	state=State.Close


func _process(delta):
	if state == State.Open:
		scale.y = clamp(scale.y-(speed*delta),0,1)
	elif state == State.Close:
		scale.y = clamp(scale.y+(speed*delta),0,1)
	if scale.y <= 0.01:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
