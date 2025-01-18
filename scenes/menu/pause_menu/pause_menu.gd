extends CanvasLayer

signal Continue
signal MainMenu

#func _process(_delta):
	#offset = Vector2(0,0)
	#scale = get_viewport_rect().size


func _on_continue_button_down():
	Continue.emit()


func _on_main_menu_button_down():
	MainMenu.emit()


func _on_exit_button_down():
	get_tree().quit()
