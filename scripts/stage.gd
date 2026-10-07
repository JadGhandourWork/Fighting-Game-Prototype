class_name Stage extends Node2D

var camera: Camera2D
var character_manager: CharacterManager
var right_boundary: PushBox
var left_boundary: PushBox

func _ready() -> void:
	camera = $Camera
	character_manager = $CharacterManager
	right_boundary = $RightBoundary
	left_boundary = $LeftBoundary

func _physics_process(_delta: float) -> void:
	adjust_boundaries()
	adjust_camera()

func adjust_boundaries() -> void:
	var char1_pos = character_manager.character1.position
	var char2_pos = character_manager.character2.position
	
	var center = (char1_pos.x + char2_pos.x) / 2
		
	var right_boundary_position = center + (Global.max_boundary_distance + right_boundary.size.x) / 2
	var left_boundary_position = center - (Global.max_boundary_distance + left_boundary.size.x) / 2
	
	if right_boundary_position - right_boundary.size.x / 2 > Global.stage_boundary:
		right_boundary_position = Global.stage_boundary + right_boundary.size.x / 2
		left_boundary_position = (right_boundary_position - left_boundary.size.x
			- Global.max_boundary_distance)
	
	if left_boundary_position + left_boundary.size.x / 2 < -Global.stage_boundary:
		left_boundary_position = -Global.stage_boundary - left_boundary.size.x / 2
		right_boundary_position = (left_boundary_position + right_boundary.size.x
			+ Global.max_boundary_distance)

	right_boundary.position.x = right_boundary_position
	left_boundary.position.x = left_boundary_position

func adjust_camera() -> void:
	var char1_pos = character_manager.character1.position
	var char2_pos = character_manager.character2.position
	
	camera.zoom = Vector2.ONE * (1000 - abs(char1_pos.x - char2_pos.x)) / 200
	if camera.zoom.x > Global.max_camera_zoom:
		camera.zoom = Vector2.ONE * Global.max_camera_zoom
	if camera.zoom.x < Global.min_camera_zoom:
		camera.zoom = Vector2.ONE * Global.min_camera_zoom
	
	var camera_width = 1920 / camera.zoom.x
	var camera_position = (char1_pos.x + char2_pos.x) / 2
	
	if camera_position > Global.stage_boundary - camera_width / 2:
		camera_position = Global.stage_boundary - camera_width / 2
	if camera_position < -Global.stage_boundary + camera_width / 2:
		camera_position = -Global.stage_boundary + camera_width / 2
	
	camera.position.x = camera_position
	
	
	
