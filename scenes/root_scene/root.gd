extends Node2D

func _ready():
	var main_menu:PackedScene = load("res://scenes/menu/main_menu/main_menu.tscn")
	add_child(main_menu.instantiate())
	get_child(-1).connect("change_scene",change_scene)

func change_scene(scenePath:String):
	var new_scene:PackedScene = load(scenePath)
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	#print(new_scene.resource_name)
	add_child(new_scene.instantiate())
	get_child(-1).connect("change_scene",change_scene)
	
