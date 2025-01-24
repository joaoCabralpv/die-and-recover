@tool
extends Camera2D
class_name LimitCamera

var topNode:Node2D = null
var bottomNode:Node2D = null
var leftNode:Node2D = null
var rightNode:Node2D = null


func _ready():
	topNode = get_node("top")
	bottomNode = get_node("bottom")
	leftNode = get_node("left")
	rightNode = get_node("right")
	limit_top = topNode.position.y
	limit_bottom = bottomNode.position.y
	limit_left = leftNode.position.x
	limit_right = rightNode.position.x

func _process(_delta):
	if Engine.is_editor_hint():
		update_configuration_warnings()
		var editor_settings:EditorSettings = EditorInterface.get_editor_settings()
		#var view2d: SubViewport = editor_settings.get_editor_viewport_2d()
		#var sprite:Sprite2D = load("res://test.tscn").instantiate()
		#MainScreen.add_child(load("res://test.tscn").instantiate())

func _get_configuration_warnings() -> PackedStringArray:
	var top:bool = false
	var bottom:bool = false
	var left:bool = false
	var right:bool = false
	
	var WarnigStringArray = []
	
	for child in get_children():
		if child is Node2D:
			if child.name.to_lower() == "top":
				if top:
					WarnigStringArray.push_back("Has two nodes named \"top\"")
				top = true
					
			if child.name.to_lower() == "bottom":
				if bottom:
					WarnigStringArray.push_back("Has two nodes named \"bottom\"")
				bottom = true
					
			if child.name.to_lower() == "left":
				if left:
					WarnigStringArray.push_back("Has two nodes named \"left\"")
				left = true
				
			if child.name.to_lower() == "right":
				if right:
					WarnigStringArray.push_back("Has two nodes named \"right\"")
				right = true
	
	if !top:
		WarnigStringArray.push_back("Has no node named top")
	if !bottom:
		WarnigStringArray.push_back("Has no node named bottom")
	if !left:
		WarnigStringArray.push_back("Has no node named left")
	if !right:
		WarnigStringArray.push_back("Has no node named right")
	
	return WarnigStringArray
