extends Control

signal change_scene(scenePath:String)

func _on_button_button_down():
	change_scene.emit("res://scenes/menu/level_menu/level_menu.tscn")
	
