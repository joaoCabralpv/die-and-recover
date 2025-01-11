extends Area2D
class_name PickupArea

var CanPickArray:Array[CanPickupArea] = []
var RemoteTransform:RemoteTransform2D = null
var is_holding:bool = false
var holding = null
func _ready():
	for child in get_children():
		if child is RemoteTransform2D:
			RemoteTransform = child
			break
	RemoteTransform.update_scale = false
	area_entered.connect(object_entered)
	area_exited.connect(object_exited)

func object_entered(body):
	if body is CanPickupArea:
		CanPickArray.push_back(body)
func object_exited(body):
	if body is CanPickupArea:
		CanPickArray.erase(body)

func _process(_delta):
	if Input.is_action_just_pressed("pick_up"):
		if !is_holding and len(CanPickArray) and get_parent().selected:
			holding = CanPickArray[0].get_parent()
			RemoteTransform.remote_path = holding.get_path()
			holding.hold()
			is_holding = true
		elif is_holding:
			RemoteTransform.remote_path = ""
			holding.release()
			holding = null
			is_holding = false
