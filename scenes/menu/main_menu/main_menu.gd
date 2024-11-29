extends Control

signal change_scene(scenePath:String)

func _ready():
	print("This game is made with godot and I need to put this link somewere in the game: godotengine.org/license\nImage assets from BFDI were taken from https://battlefordreamisland.fandom.com/wiki/Assets and are licenced under CC-BY-SA 3.0\nFont used by the HPRC is Digiface Regular")

func _on_button_button_down():
	change_scene.emit("res://scenes/menu/level_menu/level_menu.tscn")
	
