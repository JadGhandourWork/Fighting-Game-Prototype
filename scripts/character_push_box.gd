class_name CharacterPushBox extends PushBox

var character: Character
var right_boundary: PushBox
var left_boundary: PushBox

var pushback_to_apply: Array[float]

func _ready():
	super()
	character = get_parent()
	right_boundary = get_tree().get_first_node_in_group("RightBoundary")
	left_boundary = get_tree().get_first_node_in_group("LeftBoundary")
	pushback_to_apply = []

func check_collisions() -> void:
	var offsets: Array[float]
	var stuck_together = false
	
	offsets = Global.check_and_push(left_boundary, self, 1)
	if !offsets.is_empty():
		character.position.x += offsets[1]
	
	offsets = Global.check_and_push(self, right_boundary, 0)
	if !offsets.is_empty():
		character.position.x += offsets[0]
	
	offsets = Global.check_and_push(left_boundary, character.opponent.push_box, 1)
	if !offsets.is_empty():
		character.opponent.position.x += offsets[1]
	
	offsets = Global.check_and_push(character.opponent.push_box, right_boundary, 0)
	if !offsets.is_empty():
		character.opponent.position.x += offsets[0]
	
	offsets = Global.check_and_push(
		self,
		character.opponent.push_box,
		0.5,
		character.directions.find_key("forward")
	)
	if !offsets.is_empty():
		character.position.x += offsets[0]
		character.opponent.position.x += offsets[1]
		stuck_together = true
		
	offsets = Global.check_and_push(left_boundary, self, 1)
	if !offsets.is_empty():
		character.position.x += offsets[1]
		if stuck_together:
			character.opponent.position.x += offsets[1]
	
	offsets = Global.check_and_push(self, right_boundary, 0)
	if !offsets.is_empty():
		character.position.x += offsets[0]
		if stuck_together:
			character.opponent.position.x += offsets[0]
	
	offsets = Global.check_and_push(left_boundary, character.opponent.push_box, 1)
	if !offsets.is_empty():
		character.opponent.position.x += offsets[1]
		if stuck_together:
			character.position.x += offsets[1]
	
	offsets = Global.check_and_push(character.opponent.push_box, right_boundary, 0)
	if !offsets.is_empty():
		character.opponent.position.x += offsets[0]
		if stuck_together:
			character.position.x += offsets[0]

func apply_pushback() -> void:
	var pushback: float
	var offsets: Array[float]
	
	if !pushback_to_apply.is_empty():
		pushback = pushback_to_apply.pop_front()
		character.position.x += pushback * character.directions.find_key("back")
		offsets = Global.check_and_push(left_boundary, self, 1)
		if !offsets.is_empty():
			character.position.x += offsets[1]
			character.opponent.position.x += offsets[1]
		
		offsets = Global.check_and_push(self, right_boundary, 0)
		if !offsets.is_empty():
			character.position.x += offsets[0]
			character.opponent.position.x += offsets[0]
		
	
