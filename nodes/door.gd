extends StaticBody2D

class_name Door

func open():
	print("function")
	set_collision_layer_value(1,false)
			
func close():
	set_collision_layer_value(1,true)


func _on_button_presed():
	print("got signal button pressed")
	open()

func _on_button_released():
	close()
