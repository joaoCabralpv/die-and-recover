extends Node2D
class_name Level

signal change_scene(ScenePath:String)

var PlayerArray: Array[Character] = []
var DeadPlayerArray: Array[Character] = []
var SelectedPlayerIndex: int = 0 # Index of selected character on PlayerArray 

var GreenFlagArray: Array[Goal] = []
var RedFlagArray: Array[Goal] = []
var RecoveryCenterArray: Array[Recovery] = []

var camera:LimitCamera= null
var has_camera:bool = false

@onready var pause_menu = preload("res://scenes/menu/pause_menu/pause_menu.tscn").instantiate()
var is_paused:bool = false


@export var unlock_when_completed:String = ""

# Puts all characters in character array
func select_player():
	if PlayerArray.size() == 0:
		printerr("No characters in this level")
		return
	PlayerArray[0].select()
	print(PlayerArray)

func setup_goals(goal:Goal):
			match goal.Type:
				Types.GoalType.Green:
					GreenFlagArray.push_back(goal)
				Types.GoalType.Red:
					RedFlagArray.push_back(goal)
				_:
					print("unsoported goal type")

func setup_objects():
	for child in get_children():
		if child is Character:
			PlayerArray.push_back(child)
		elif child is Recovery:
			var recovery_center:Recovery = child
			recovery_center.recover.connect(_recover_player)
			RecoveryCenterArray.push_back(child)
		elif child is Goal:
			setup_goals(child)
		elif child is LimitCamera:
			camera = child
			has_camera = true
			

func _ready():
	setup_objects()
	select_player()
	pause_menu.Continue.connect(continue_game)
	pause_menu.MainMenu.connect(main_menu)
	

func kill_player(player:Character):
	player.kill()
	DeadPlayerArray.push_back(player)
	if DeadPlayerArray.size() == PlayerArray.size():
		print("All players are dead")

func _recover_player(player:Character):
	player.recover()
	DeadPlayerArray.erase(player)
	
	
func check_typing_hprc() -> bool:
	for center in RecoveryCenterArray:
		if center.typingName:
			return true
	return false

func swap_character():
	for i in range(PlayerArray.size()): # Finds the next living chracter on the SelectedSelectedPlayerIndex
		PlayerArray[SelectedPlayerIndex].unselect()
		SelectedPlayerIndex+=1
		SelectedPlayerIndex%=PlayerArray.size() # If the SelectedSelectedPlayerIndex is bigger than max index alowed by PlayerArray, it goes back to 0
		if !PlayerArray[SelectedPlayerIndex].is_dead: 
			PlayerArray[SelectedPlayerIndex].select()
			return # Returns from the function if a living character is found
	print("All players are dead")
	
func check_goals() -> bool:
	return check_green_flags() and check_red_flags()
	  
func check_green_flags() -> bool:
	if GreenFlagArray.size() == 0:
		return true
	for goal in GreenFlagArray:
		if goal.colliding > 0:
			return true
	return false
	
func check_red_flags() -> bool:
	if RedFlagArray.size() == 0:
		return true
	for goal in RedFlagArray:
		if goal.colliding == 0:
			return false
	return true

func update_camera():
	camera.position = PlayerArray[SelectedPlayerIndex].position
	
func continue_game():
	print("continue")
	is_paused = false
	remove_child(pause_menu)
func main_menu():
	change_scene.emit("res://scenes/menu/main_menu/main_menu.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("swap") and PlayerArray.size() > 0 and !check_typing_hprc():
		swap_character()
	if check_goals():
		UnlockedLevels.unlock_level(unlock_when_completed)
		change_scene.emit("res://scenes/menu/level_menu/level_menu.tscn")
	
	if Input.is_action_just_pressed("pause"):
		if !is_paused:
			var pause:bool = true
			for center in RecoveryCenterArray:
				if center.typingName:
					pause = false
					break
			if pause:
				is_paused = true
				add_child(pause_menu)
				#get_tree().paused = true
			
	if has_camera:
		update_camera()
