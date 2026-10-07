extends CharacterState

@export var walk_state: State
@export var prejump_state: State
@export var dash_state: State
@export var five_p_state: State

func enter_state() -> void:
	character.velocity = Vector2.ZERO
	character.hurt_box.set_polygon(character.data.idle_hurt_box)
	character.anim.play("Idle")

func update(_delta: float) -> void:
	if character.input.is_x():
		switch_state.emit(walk_state)
		return

	if character.input.is_up():
		switch_state.emit(prejump_state)
		return

	if character.input.is_just_pressed("dash"):
		switch_state.emit(dash_state)
		return
	
	if character.input.is_just_pressed("p"):
		switch_state.emit(five_p_state)
		return

func physics_update(_delta: float) -> void:
	character.custom_physics()
	character.check_and_turn_around()
