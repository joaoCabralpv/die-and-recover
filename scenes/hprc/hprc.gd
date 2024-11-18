extends Recovery

signal recover(player:Character)

@onready var textInput:LineEdit = $HPRCKeyboard.get_child(0)
var typingName:bool = false
@onready var level:Level = $".."
var PlayerNameArray:Array[String] = []

func _ready():
	return
	for player in level.PlayerArray:
		PlayerNameArray.push_back(player.name)
		

var PlayerArray:Array[Character] = []
#var characters_in_hprc: int = 0

func _on_area_2d_body_entered(body):
	if body is Character:
		var chara = body
		PlayerArray.push_back(chara)
		
func _on_area_2d_body_exited(body):
	if body is Character:
		print(body," left")
		PlayerArray.erase(body)
		
func hprc_handler():
		$HPRCKeyboard.visible = true
		typingName = true
		for chara in PlayerArray:
			chara.in_hprc = true
			
func typing_handler():
	#print(textInput.text)
	#print("hprc ",level.DeadPlayerArray)
	for player in level.DeadPlayerArray:
		#print("player ",player.name)
		#print("text ",textInput.text)
		if textInput.text.to_lower().replace(" ","") == player.name.to_lower().replace(" ",""):
		#	print("\n\n\n\n\n\nAAAA")
			emit_signal("recover",player)
			player.position = position
			textInput.text = ""
			typingName = false
			for chara in PlayerArray:
				chara.in_hprc = false

func _process(_delta):
	if Input.is_action_just_pressed("use_hprc") and PlayerArray.size() > 0 and !typingName:
		hprc_handler()
	if typingName:
		typing_handler()
