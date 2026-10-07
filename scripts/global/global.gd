extends Node

signal attack(player: String)

const p1_hurt_box_layer = 5
const p2_hurt_box_layer = 6
const p1_strikes_layer = 7
const p2_strikes_layer = 8

const stage_boundary = 650
const max_boundary_distance = 680

const roundstart_distance = 200

const min_camera_zoom = 2.823529411764706
const max_camera_zoom = 3.8

const input_history_size = 30

const input_buffer = 4
const landing_input_buffer = 2

const juggle_gravity: float = 15
var inaba_data = InabaData.new()

func check_and_push(
	push_box1: PushBox,
	push_box2: PushBox,
	weight_ratio,
	order: int = 1) -> Array[float]:
	
	var horizontal_distance = push_box1.global_position.x - push_box2.global_position.x
	
	var _sign: int
	if horizontal_distance == 0:
		_sign = -order
	else:
		_sign = sign(horizontal_distance)
	
	var safe_distance = (push_box1.size.x/2 + push_box2.size.x/2) * _sign
	
	var vertical_distance = abs(push_box1.global_position.y - push_box2.global_position.y)
	var colliding_height_difference = push_box1.size.y/2 + push_box2.size.y/2
	
	if (abs(horizontal_distance) - abs(safe_distance) < 0
		&& vertical_distance < colliding_height_difference):
			
		var overlap = safe_distance - horizontal_distance
		
		return [overlap * (1 - weight_ratio), -overlap * weight_ratio]
		
	return []
