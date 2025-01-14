extends Area2D
class_name PickupArea

var CanPickArray:Array[CanPickupArea] = []
var HeldObjectCollisions:Array[Node2D] = []
var RemoteTransform:RemoteTransform2D = null
var is_holding:bool = false
var holding:RigidBody2D = null

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
#region Pick up object
			holding = CanPickArray[0].get_parent()
			RemoteTransform.remote_path = holding.get_path()
			
			for child in holding.get_children():
				if child is CollisionShape2D or child is CollisionPolygon2D:
					
					var child_new:Node2D = child.duplicate()
					child_new.name="_HoldingCollision"+child_new.name
					child_new.position+=RemoteTransform.position
					child_new.scale/=RemoteTransform.global_scale
					get_parent().add_child(child_new)
					
					HeldObjectCollisions.push_back(child_new)
			is_holding = true
#endregion
		elif is_holding:
#region Release object
			RemoteTransform.remote_path = ""
			holding = null
			is_holding = false
			
			for collision in HeldObjectCollisions:
				collision.queue_free()
			HeldObjectCollisions = []
#endregion
