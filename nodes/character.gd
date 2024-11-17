extends CharacterBody2D
class_name Character

@export var walking_speed = 300
@export var jump_speed = 1000
var gravity = Gravity.gravity

var selected :bool = false
var is_dead :bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func move():
	if Input.is_action_pressed("right"):
		velocity.x += walking_speed
	if Input.is_action_pressed("left"):
		velocity.x -= walking_speed
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_speed
func update():
	velocity.y+=gravity
	if velocity.y < -jump_speed:
		velocity.y = -jump_speed
	"""if velocity.y > -INF and selected:
		for i in get_slide_collision_count():
			var collided = get_slide_collision(i).get_collider()
			if collided is Character :#and get_slide_collision(i).get_angle() == Vector2.UP:
				print(self)
				print("collision angle: "+str(get_slide_collision(i).get_angle()))
				var character :Character = collided
				if Extras.between(get_slide_collision(i).get_angle(), PI-0.0001, PI+0.0001):
					print("collision from above")
					collided.test(velocity.y)
					
					#collided.position.y+=velocity.y
					#print("collided: "+str(collided))
					#collided.move_and_slide()
				"""
	move_and_slide()
	velocity.x = 0

	
#func _ready():
	#Player.PlayerArray.push_back(self)	

func _process(delta):
	if selected:
		move()
	update()
