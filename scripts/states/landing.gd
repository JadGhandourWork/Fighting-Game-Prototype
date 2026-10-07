extends CharacterState

@export var idle_state: State
@export var five_p_state: State

var current_frame: int

func enter_state() -> void:
	character.state_machine.airborne = false
	character.velocity = Vector2.ZERO
	current_frame = 1
	character.anim.play("Landing")
	
func update(_delta: float) -> void:
	if character.input.is_just_pressed("p", Global.landing_input_buffer):
		switch_state.emit(five_p_state)
		return
	
	if current_frame > character.data.landing:
		switch_state.emit(idle_state)
		return
	
func physics_update(_delta: float) -> void:
	character.custom_physics()
	current_frame += 1

func exit_state() -> void:
	character.check_and_turn_around()
