extends Area2D
class_name Goal

var colliding:int = 0

func _on_body_entered(body):
	if body is Character:
		colliding+=1
	print(colliding)


func _on_body_exited(body):
	if body is Character:
		colliding-=1
	print(colliding)
