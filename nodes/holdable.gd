extends RigidBody2D
"""
var CollisionArray:Array[Node2D] = []
var holder:Character = null
var holder_path = ""
var CorrespondingHolderCollisionArray:Array[Node2D] = []

func _ready():
	for child in get_children():
		if child is CollisionShape2D or child is CollisionPolygon2D:
			CollisionArray.push_back(child)

func _process(_delta):
	if holder == null:
		return
	for i in range(len(CorrespondingHolderCollisionArray)):
		CorrespondingHolderCollisionArray[i].global_position = CollisionArray[i].global_position
		print(CorrespondingHolderCollisionArray[i].global_position)

func hold(character:Character):
	holder=character
	holder_path=holder.get_path()
	for shape in CollisionArray:
		var new_node:Node2D = shape.duplicate()
		new_node.name = "_holdercollision"+name+new_node.name
		holder.add_child(new_node) 
		var correspoinding_holder_child:Node2D = get_node(str(holder_path)+"/"+new_node.name)	
		CorrespondingHolderCollisionArray.push_back(correspoinding_holder_child)
		
func release():
	for child in holder.get_children():
		if child.name.begins_with("_holdercollision"+name) and (child is CollisionShape2D or child is CollisionPolygon2D):
			holder.remove_child(child)
			child.queue_free()
	holder = null
	holder_path=""
	CollisionArray=[]
	CorrespondingHolderCollisionArray=[]
"""
func _ready():
	contact_monitor = true
	max_contacts_reported = 64
