extends StaticBody2D
class_name Door

var state:Types.DoorState = Types.DoorState.Close

@export var speed = 3

func change_state(new_state:Types.DoorState):
	state = new_state

func _process(delta):
	if state == Types.DoorState.Open:
		scale.y = clamp(scale.y-(speed*delta),0,1)
	elif state == Types.DoorState.Close:
		scale.y = clamp(scale.y+(speed*delta),0,1)
	if scale.y <= 0.01:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
