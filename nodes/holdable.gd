extends Node

var CollisionShapeArray:Array[CollisionShape2D] = []
var CollisionPolygonArray:Array[CollisionPolygon2D] = []

func _ready():
	for child in get_children():
		if child is CollisionShape2D:
			CollisionShapeArray.push_back(child)
		if child is CollisionPolygon2D:
			CollisionPolygonArray.push_back(child)
			
func hold():
	for shape:CollisionShape2D in CollisionShapeArray:
		shape.disabled = true
	for polygon:CollisionPolygon2D in CollisionPolygonArray:
		polygon.disabled = true
		
func release():
	for shape:CollisionShape2D in CollisionShapeArray:
		shape.disabled = false
	for polygon:CollisionPolygon2D in CollisionPolygonArray:
		polygon.disabled = false
