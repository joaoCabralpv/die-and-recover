extends Control

signal change_scene(Path:String)

func _ready():
	for child in $GridContainer.get_children():
		if child is LevelMenuButton:
			child.level_selected.connect(level_selected)
			
func level_selected(LevelPath:String):
	change_scene.emit(LevelPath)
