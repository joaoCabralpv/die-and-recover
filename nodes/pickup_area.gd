extends Area2D
class_name PickupArea

var CanPickArray:Array[CanPickupArea] = []
var HeldObjectCollisions:Array[Node2D] = []
var RemoteTransform:RemoteTransform2D = null
var is_holding:bool = false
var holding:CharacterBody2D = null
var start_holding_this_frame = false
@onready var parent:Character= get_parent()

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
	start_holding_this_frame = false
	if Input.is_action_just_pressed("trow_object") or Input.is_action_just_pressed("put_down_object"):
		if !is_holding and len(CanPickArray) and parent.selected:
#region Pick up object
			holding = CanPickArray[0].get_parent()
			
			RemoteTransform.remote_path = holding.get_path()
			for child in holding.get_children():
				if child is CollisionShape2D or child is CollisionPolygon2D:
					var child_new:Node2D = child.duplicate()
					child_new.name="_HoldingCollision"+child_new.name
					child_new.position+=RemoteTransform.position
					child_new.scale/=RemoteTransform.global_scale
					parent.add_child(child_new)
					HeldObjectCollisions.push_back(child_new)

			is_holding = true
			start_holding_this_frame = true
			holding.global_position=RemoteTransform.global_position
			holding.ApplyPush.connect(ApplyPush)
			holding.picked()
#endregion
		elif is_holding:
#region Release object
			print("RELEASED AAAAAAAAAAAAAAAAAAAAAAAAAAh ")
			var velocity:Vector2 = parent.velocity
			print("Character: ",velocity)
			if Input.is_action_just_pressed("trow_object"):
				velocity.y-=900
			else: #Input.is_action_just_pressed("put_down_object")
				velocity.x = 43.54
			holding.velocity = velocity
			release_object()
			
func release_object():
			RemoteTransform.remote_path = ""
			holding.ApplyPush.disconnect(ApplyPush)
			holding.released()
			holding = null
			is_holding = false
			
			for collision in HeldObjectCollisions:
				collision.queue_free()
			HeldObjectCollisions = []
			
#endregion

func ApplyPush():
	#print("ApplyPush")
	if !start_holding_this_frame:
		parent.velocity.x=parent.direction*parent.walking_speed*-1.5
		parent.move_and_slide()
