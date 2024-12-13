extends Node2D

func _ready():
	print("""This game is made with godot and I need to put this link somewere in the game: godotengine.org/license
Image assets from BFDI were taken from https://battlefordreamisland.fandom.com/wiki/Assets and are licenced under CC-BY-SA 3.0
Font used by the HPRC is Digiface Regular""")

	change_scene("res://scenes/menu/main_menu/main_menu.tscn")

func change_scene(scenePath:String):
	var new_scene:PackedScene = load(scenePath)
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	#print(new_scene.resource_name)
	add_child(new_scene.instantiate())
	get_child(-1).connect("change_scene",change_scene)
	
