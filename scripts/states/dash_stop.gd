extends CharacterState

@export var idle_state: State
@export var prejump_state: State
@export var walk_state: State
@export var dash_state: State
@export var backdash_state: State
@export var five_p_state: State

var current_frame: int

func enter_state() -> void:
	current_frame = 1
	
	character.anim.play("Dash Stop")
	
func update(_delta: float) -> void:	
	
	if character.input.is_up():
		switch_state.emit(prejump_state)
		return
		
	if character.input.is_just_pressed("back") && character.input.is_just_pressed("dash"):
		switch_state.emit(backdash_state)
		return
		
	if current_frame > character.data.dash_stop_duration:
		switch_state.emit(idle_state)
		return
	
	if character.input.is_just_pressed("p", 6):
		switch_state.emit(five_p_state)
		return

	if (current_frame >= character.data.dash_stop_cancel):
		if character.input.is_just_pressed("dash") && !character.input.is_back():
			switch_state.emit(dash_state)
			return
		
		if character.input.is_x():
			switch_state.emit(walk_state)
			return
	
func physics_update(_delta: float) -> void:
	character.velocity.x *= character.data.dash_stop_friction
	
	character.custom_physics()
	
	current_frame += 1

func exit_state() -> void:
	character.check_and_turn_around()
