extends Node2D
class_name Level

signal change_scene(ScenePath:String)

var PlayerArray: Array[Character] = []
var DeadPlayerArray: Array[Character] = []
var PlayerIndex: int = 0 # Index of selected character on PlayerArray 

var GoalArray: Array[Goal] = []

var camera:LimitCamera= null
var has_camera:bool = false
var NotifierArray: Array[VisibleOnScreenNotifier2D] = []

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
			
func setup_goals():
	for child in get_children():
		if child is Goal:
			GoalArray.push_back(child)
			
func setup_camera():
	for child in get_children():
		if child is LimitCamera:
			camera = child
			has_camera = true
			print("!!!!!!!!!!!!!!")
			setup_visible_notifiers()

func setup_visible_notifiers():
		for child in get_children():
				if child is VisibleOnScreenNotifier2D:
					NotifierArray.push_back(child)

func _ready():
	setup_player_array()
	setup_kill_areas()
	setup_recovery_centers()
	setup_goals()
	setup_camera()
	

func _kill_player(object):
	if object is Character:
		object.kill()
		DeadPlayerArray.push_back(object)
		if DeadPlayerArray.size() == PlayerArray.size():
			print("All players are dead")

func _recover_player(player:Character):
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
	
func check_goals() -> bool:
	for goal in GoalArray:
		print(goal)
		if goal.colliding > 0:
			return true
	return false

func update_camera():
	camera.position = PlayerArray[PlayerIndex].position

func _process(_delta):
	if Input.is_action_just_pressed("swap") and PlayerArray.size() > 0:
		swap_character()
	if check_goals():
		UnlokedLevels.unlock_level("2")
		change_scene.emit("res://scenes/menu/level_menu/level_menu.tscn")
	if has_camera:
		update_camera()
