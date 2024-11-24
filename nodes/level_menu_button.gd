extends Button

class_name LevelMenuButton

signal level_selected(LevelPath:String)

#@export var Text: String
@export var LevelPath: String

"""func _ready():
	text = Text"""
	
func _ready():
	disabled = true
	for level in UnlokedLevels._UnlokedLevels:
		if level == text:
			disabled = false
			break

func _pressed():
	level_selected.emit(LevelPath)
