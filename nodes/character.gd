extends CharacterBody2D
class_name Character

@export var walking_speed = 600
@export var jump_speed = 1000
@export var spring_jumping_speed = 1000
var spring_and_jump_jumping_speed = (jump_speed+spring_jumping_speed)*2/3
var gravity = Gravity.gravity

var selected :bool = false
var is_dead :bool = false
var in_hprc :bool = false

var on_spring:bool = true
var just_entered_spring:bool = false
var jump_with_spring:bool = false

func input():
	if Input.is_action_pressed("right"):
		velocity.x += walking_speed
	if Input.is_action_pressed("left"):
		velocity.x -= walking_speed
	if Input.is_action_just_pressed("jump") and (is_on_floor()or on_spring):
		on_spring = false
		velocity.y -= jump_speed     
					   
func move():
	velocity.y+=gravity
	if just_entered_spring:
		if velocity.y > 0:
			velocity.y = 0
		velocity.y -= spring_jumping_speed
		just_entered_spring = false
	# Caps upwards velocity to jump speed
	if velocity.y < -jump_speed-spring_jumping_speed:
		velocity.y = -jump_speed-spring_jumping_speed
	move_and_slide()
	velocity.x = 0

func extra():
	return

func _process(_delta):
	if selected and !is_dead and !in_hprc:
		input()
	move()
	extra()

func select():
	selected = true
	#collision_layer = 0b1
	#collision_mask = 0b100
	
func unselect():
	selected = false
	#collision_layer = 0b10
	#collision_mask = 0b111

func kill():
	is_dead = true
	for child in get_children():
		if child is CollisionPolygon2D or child is CollisionShape2D:
			child.set_deferred("disabled",true)
	visible = false
	
func recover():
	is_dead = false
	for child in get_children():
		if child is CollisionPolygon2D or child is CollisionShape2D:
			child.set_deferred("disabled",false)
	visible = true
	velocity = Vector2.ZERO
