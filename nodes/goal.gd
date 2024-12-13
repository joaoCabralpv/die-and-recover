extends Area2D
class_name Goal

@export var Type:Types.GoalType

var colliding:int = 0

func _on_body_entered(body):
	if body is Character:
		colliding+=1


func _on_body_exited(body):
	if body is Character:
		colliding-=1
