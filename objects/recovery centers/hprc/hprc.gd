extends Recovery

signal recover(player:Character)

@onready var textInput:LineEdit = $HPRCKeyboard.get_child(0)
@onready var level:Level = $".."

var PlayerArray:Array[Character] = []
#var characters_in_hprc: int = 0

#These two function (_on_area_2d_body_entered and _on_area_2d_body_exited) keep track of the characters coliding in the hprc
func _on_area_2d_body_entered(body):
	if body is Character:
		var character = body
		PlayerArray.push_back(character)
		
func _on_area_2d_body_exited(body): 
	if body is Character:
		#print(body," left")
		PlayerArray.erase(body)
		
func hprc_handler():
		$HPRCKeyboard.visible = true
		typingName = true
		for character in PlayerArray:
			character.in_hprc = true
			
func typing_handler():
	textInput.grab_focus()
	if Input.is_action_just_pressed("exit_hprc"):
		exit_hprc()
	for player in level.DeadPlayerArray: #Loops trough all dead players
		# Checks if tyed text is equal to a name of a dead character after removig the spaces
		if textInput.text.to_lower().replace(" ","") == player.name.to_lower().replace(" ",""): 
			recover.emit(player)
			player.position = position # Sets the player position to the hprc
			exit_hprc()

func exit_hprc():
	textInput.text = "" # Clears the text in textInput
	$HPRCKeyboard.visible = false
	typingName = false
	for character in PlayerArray:
		character.in_hprc = false 

func _process(_delta):
	var selected:Character = level.PlayerArray[level.SelectedPlayerIndex]
	if Input.is_action_just_pressed("use_hprc") and selected in PlayerArray and !typingName:
		hprc_handler()
	if typingName:
		typing_handler()
