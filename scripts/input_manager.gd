class_name InputManager extends Node2D

var inputs: Array[InputFrame]
var next_input: InputFrame
var character: Character

func _ready() -> void:
	next_input = InputFrame.new()
	for i in range(0, Global.input_history_size):
		inputs.append(InputFrame.new())
	character = get_parent()

func _process(_delta: float) -> void:
	next_input.x =  Input.get_axis(character.player + " Left",
		character.player + " Right")
	next_input.y = Input.get_axis(character.player + " Up",
		character.player + " Down")
	next_input.dash = Input.is_action_pressed(character.player + " Dash")
	next_input.p = Input.is_action_pressed(character.player + " P")

func _physics_process(_delta: float) -> void:
	inputs.push_front(next_input)
	clear_inputs()
	next_input = InputFrame.new()

func clear_inputs() -> void:
	if inputs.size() > Global.input_history_size:
		inputs.pop_back()

func clear_specific_input(button: String) -> void:
	for input in inputs:
		match button:
			"p":
				input.p = false
		
func is_x(i: int = 0) -> bool:
	return inputs[i].x != 0

func is_forward(i: int = 0) -> bool:
	return character.directions.get(inputs[i].x, "") == "forward"

func is_back(i: int = 0) -> bool:
	return character.directions.get(inputs[i].x, "") == "back"

func is_up(i: int = 0) -> bool:
	return inputs[i].y == -1

func is_dash(i: int = 0) -> bool:
	return inputs[i].dash
	
func is_p(i: int = 0) -> bool:
	return inputs[i].p

func is_just_pressed(button: String, buffer: int = Global.input_buffer) -> bool:
	var input1: bool
	var input2: bool
	
	for i in range(0,buffer):
		match button:
			"dash":
				input1 = is_dash(i)
				input2 = is_dash(i+1)
			"back":
				input1 = is_back(i)
				input2 = is_back(i+1)
			"p":
				input1 = is_p(i)
				input2 = is_p(i+1)
		if input1 && !input2:
			return true
			
	return false
