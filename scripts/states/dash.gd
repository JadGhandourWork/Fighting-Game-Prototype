extends CharacterState

@export var dash_stop_state: State
@export var prejump_state: State
@export var backdash_state: State
@export var five_p_state: State

var held_for: int = 0
var forward: float

func enter_state() -> void:
	held_for = 0
	forward = character.directions.find_key("forward")
	character.velocity.x = forward * character.data.initial_dash_speed

func update(_delta: float) -> void:
	if held_for == character.data.dash_backdash_cancel:
		character.anim.play("Dash")
	
	if character.input.is_up():
		switch_state.emit(prejump_state)
		return
	
	if (character.input.is_just_pressed("back") &&
		character.input.is_just_pressed("dash", character.data.dash_backdash_cancel)):
		switch_state.emit(backdash_state)
		return
	
	if !character.input.is_forward() && !character.input.is_dash():
		switch_state.emit(dash_stop_state)
		return
	
	if character.input.is_just_pressed("p"):
		switch_state.emit(five_p_state)
		return

func physics_update(_delta: float) -> void:
	character.velocity.x *= character.data.dash_acceleration
	if abs(character.velocity.x) > character.data.max_dash_speed:
		character.velocity.x = forward * character.data.max_dash_speed
	
	character.custom_physics()
	
	held_for += 1
