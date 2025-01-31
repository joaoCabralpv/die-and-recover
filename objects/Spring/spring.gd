extends Node

func _on_body_entered(body):
	if body is Character:
		body.just_entered_spring=true
		body.on_spring=true
	elif body is CharacterBody2D:
		body.velocity.y =-1000

func _on_body_exited(body):
	if body is Character:
		body.on_spring=false
		body.just_entered_spring=false
