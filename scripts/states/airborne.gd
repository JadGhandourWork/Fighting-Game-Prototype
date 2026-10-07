extends CharacterState

@export var landing_state: State

func enter_state() -> void:
	character.state_machine.airborne = true
	
	character.velocity.y = character.data.jump_velocity
	
	if abs(character.velocity.x) < character.data.max_neutral_jump_velocity:
		character.anim.play("Jump")
		character.anim.queue("Airborne")
		return
	
	var axis = character.velocity.x / abs(character.velocity.x)
	var direction = character.directions.get(axis, "forward")
	
	character.anim.play(character.data.jump_animation_dic.get(direction))
	character.anim.queue(character.data.airborne_animation_dic.get(direction))

func physics_update(_delta: float) -> void:
	character.velocity.y += character.data.gravity
	
	if character.custom_physics():
		if character.get_last_slide_collision().get_collider().get_collision_layer() == 1:
			switch_state.emit(landing_state)
