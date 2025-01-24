extends Area2D
class_name KillArea

signal kill_player(player)

@onready var parent:Level = get_parent()
func _ready():
	kill_player.connect(parent.kill_player)
	body_entered.connect(body_collided)
	
func body_collided(body):
	printerr(name,"'s body_collided() is not defined")
