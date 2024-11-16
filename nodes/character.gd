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
	move_and_slide()
	velocity.x = 0
	
#func _ready():
	#Player.PlayerArray.push_back(self)	
	
func _process(delta):
	if selected:
		move()
	update()
