extends Node2D
class_name Level

var PlayerArray: Array[Character] = []
var PlayerIndex: int = 0

func _ready():
	for child in get_children():
		if child is Character:
			PlayerArray.push_back(child)
	if PlayerArray.size() == 0:
		printerr("No characters in this level")
		return
	PlayerArray[0].selected = true
	print(PlayerArray)

func _process(delta):
	if Input.is_action_just_pressed("swap") and PlayerArray.size() > 0:
		PlayerArray[PlayerIndex].selected = false
		PlayerIndex+=1
		PlayerIndex%=PlayerArray.size()
		PlayerArray[PlayerIndex].selected = true
	print(PlayerArray[PlayerIndex])
