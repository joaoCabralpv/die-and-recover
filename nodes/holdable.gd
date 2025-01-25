extends CharacterBody2D
var gravity = Gravity.gravity

var CollisionArray:Array[Node2D] = []
var held = false

signal ApplyPush

func _process(delta):
	scale.y=1
	velocity.y+=gravity
	move_and_slide()
	if get_slide_collision_count() > 0:
		velocity.x = 0
	if CollisionArray:
		ApplyPush.emit()

func _on_bottom_body_entered(body):
	if (body is TileMapLayer or body is StaticBody2D) and held:
		print(body.name," entered")
		CollisionArray.push_back(body)


func _on_bottom_body_exited(body):
	if body is TileMapLayer or body is StaticBody2D:
		print(body.name," exited")
		CollisionArray.erase(body)
		
func picked():
	held=true
func released():
	held=false
