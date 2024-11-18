extends Node2D
class_name Level

var PlayerArray: Array[Character] = []
var DeadPlayerArray: Array[Character] = []
var PlayerIndex: int = 0 # Index of selected character on PlayerArray 

# Puts all characters in character array
func setup_player_array():
	for child in get_children():
		if child is Character:
			PlayerArray.push_back(child)
	if PlayerArray.size() == 0:
		printerr("No characters in this level")
		return
	PlayerArray[0].selected = true
	print(PlayerArray)
	
# Creates a signal to all kill areas
func setup_kill_areas():
	for child in get_children():
		if child is KillArea:
			var kill_area:KillArea = child
			kill_area.body_entered.connect(_kill_player)
			
func setup_recovery_centers():
	for child in get_children():
		if child is Recovery:
			var recovery_center:Recovery = child
			recovery_center.recover.connect(_recover_player)

func _ready():
	print("This game is made with godot and I need to put this link somewere in the game: godotengine.org/license\nImage assets from BFDI were taken from https://battlefordreamisland.fandom.com/wiki/Assets and are licenced under CC-BY-SA 3.0\nFont used by the HPRC is Digiface Regular")
	setup_player_array()
	setup_kill_areas()
	setup_recovery_centers()

func _kill_player(object):
	if object is Character:
		object.kill()
		DeadPlayerArray.push_back(object)

func _recover_player(player:Character):
	#print("a")
	player.recover()
	DeadPlayerArray.erase(player)
	
func swap_character():
	for i in range(PlayerArray.size()): # Finds the next living chracter on the PlayerIndex
		PlayerArray[PlayerIndex].selected = false
		PlayerIndex+=1
		PlayerIndex%=PlayerArray.size() # If the PlayerIndex is bigger than max index alowed by PlayerArray, it goes back to 0
		if !PlayerArray[PlayerIndex].is_dead: 
			PlayerArray[PlayerIndex].selected = true
			return # Returns from the function if a living character is found
	print("All players are dead")
	#print(PlayerArray[PlayerIndex])

func _process(_delta):
	#print(DeadPlayerArray)
	if Input.is_action_just_pressed("swap") and PlayerArray.size() > 0:
		swap_character()
