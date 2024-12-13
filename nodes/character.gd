extends CharacterBody2D
class_name Character

@export var walking_speed = 300
@export var jump_speed = 500
var gravity = Gravity.gravity

var selected :bool = false
var is_dead :bool = false
var in_hprc :bool = false
#var velocity :Vector2 = Vector2.ZERO

	
func move():
	if Input.is_action_pressed("right"):
		velocity.x += walking_speed
	if Input.is_action_pressed("left"):
		velocity.x -= walking_speed
	if Input.is_action_just_pressed("jump") and is_on_floor() :#and prevent_double_jumps():
		velocity.y -= jump_speed                                       
#                                                                       
# This function prevents double jumps(jumping out of a character that is in mid air)
# when used in the move function here(unused becuse collision between characters is disabled)
"""func prevent_double_jumps():
	#var return_value = false
	for i in get_slide_collision_count():
		var colliding = get_slide_collision(i).get_collider()
		if colliding is Character:
			var character:Character = colliding
			for j in character.get_slide_collision_count():
				if character.is_on_floor() and character.prevent_double_jumps():
					return true
		else:
			return true
	return false
"""
func update():
	velocity.y+=gravity
	# Caps upwards velocity to jump speed
	if velocity.y < -jump_speed:
		velocity.y = -jump_speed
	move_and_slide()
	velocity.x = 0

func extra():
	return

func _process(_delta):
	if selected and !is_dead and !in_hprc:
		move()
	update()
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
