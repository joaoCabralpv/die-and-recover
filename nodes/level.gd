extends Node2D
class_name Level

var PlayerArray: Array[Character] = []
var PlayerIndex: int = 0

func setup_player_array():
	for child in get_children():
		if child is Character:
			PlayerArray.push_back(child)
	if PlayerArray.size() == 0:
		printerr("No characters in this level")
		return
	PlayerArray[0].selected = true
	print(PlayerArray)
	
func setup_kill_areas():
	for child in get_children():
		if child is KillArea:
			var kill_area:KillArea = child
			kill_area.body_entered.connect(_kill_player)
			print("1")

func _ready():
	setup_player_array()
	setup_kill_areas()

func _kill_player(player:Character):
	player.kill()
	"""for child in player.get_children():
		if child is CollisionShape2D or CollisionPolygon2D:
			child.Disabled = true"""
	#print("")
	"""print(str(player.name)+" died")
	for child in player.get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			child.Disabled = true
	player.is_dead = true"""
	
	
func swap_character():
	for i in range(PlayerArray.size()):
		PlayerArray[PlayerIndex].selected = false
		PlayerIndex+=1
		PlayerIndex%=PlayerArray.size()
		if !PlayerArray[PlayerIndex].is_dead:
			PlayerArray[PlayerIndex].selected = true
			return
	print("All players are dead")
	#print(PlayerArray[PlayerIndex])

func _process(delta):
	if Input.is_action_just_pressed("swap") and PlayerArray.size() > 0:
		swap_character()
