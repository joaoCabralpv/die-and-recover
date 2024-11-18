extends CharacterBody2D
class_name Character

@export var walking_speed = 300
@export var jump_speed = 500
var gravity = Gravity.gravity

var selected :bool = false
var is_dead :bool = false
var in_hprc :bool = false

func move():
	if Input.is_action_pressed("right"):
		velocity.x += walking_speed
	if Input.is_action_pressed("left"):
		velocity.x -= walking_speed
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= jump_speed
		
func update():
	velocity.y+=gravity
	# Caps upwards velocity to jump speed
	if velocity.y < -jump_speed:
		velocity.y = -jump_speed
	move_and_slide()
	velocity.x = 0


func _process(_delta):
	if selected and !is_dead and !in_hprc:
		move()
	update()

func kill():
	is_dead = true
	for child in get_children():
		if child is CollisionPolygon2D or child is CollisionShape2D:
			child.set_deferred("disabled",true)
	visible = false
	
func recover():
	is_dead = true
	for child in get_children():
		if child is CollisionPolygon2D or child is CollisionShape2D:
			child.set_deferred("disabled",false)
	visible = true
