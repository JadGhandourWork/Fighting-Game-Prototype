class_name PushBox extends Area2D

var size: Vector2

func _ready():
	size = $CollisionShape2D.shape.size
