extends CharacterBody2D

@export var walking_speed = 300
@export var jump_speed = 1000
var gravity = Gravity.gravity

# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = 0 
	if Input.is_action_pressed("right"):
		velocity.x += walking_speed
	if Input.is_action_pressed("left"):
		velocity.x -= walking_speed
	if Input.is_action_just_pressed("jump"):
		velocity.y -= jump_speed
	velocity.y+=gravity
	move_and_slide()
