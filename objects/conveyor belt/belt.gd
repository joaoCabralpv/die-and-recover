extends Area2D

var non_player_array:Array[CharacterBody2D] = []
@export var speed = 300

func _on_body_entered(body):
	if body is Character:
		body.colliding_conveyor_belt += 1
		body.conveyor_belt_speed = speed
	elif body is CharacterBody2D:
		non_player_array.push_back(body)

func _on_body_exited(body):
	if body is Character:
		body.colliding_conveyor_belt -= 1
	elif body is CharacterBody2D:
		non_player_array.erase(body)

func _process(_delta):
	for object in non_player_array:
		object.velocity.x=speed
