extends CharacterState

@export var airborne_state: State

var current_frame: int
var axis: float
var velocity: Vector2

func enter_state() -> void:
	velocity = character.velocity
	character.velocity = Vector2.ZERO
	current_frame = 1
	character.anim.play("Prejump")

func update(_delta: float) -> void:
	axis = character.input.inputs[0].x
	
	if !frame_computed:
		if (character.input.is_forward()
			&& abs(velocity.x) < character.data.walk_dic["forward"]):
			velocity.x = axis * character.data.walk_dic["forward"]
		
		if character.input.is_back():
			velocity.x = axis * character.data.walk_dic["back"]
		
		frame_computed = true
	
	if current_frame > character.data.prejump:
		switch_state.emit(airborne_state)
		return

func physics_update(_delta: float) -> void:
	character.custom_physics()
	
	current_frame += 1
	frame_computed = false
	

func exit_state() -> void:
	character.velocity = velocity
