extends CharacterState

@export var idle_state: State
@export var prejump_state: State
@export var dash_state: State
@export var backdash_state: State
@export var five_p_state: State

var direction: String

func enter_state() -> void:
	character.check_and_turn_around()
	
	if character.input.is_back():
		direction = "back"
	else:
		direction = "forward"
	
	character.velocity.x = (character.input.inputs[0].x
		* character.data.walk_dic.get(direction))
	
	character.anim.play(character.data.walk_animation_dic[direction])

func update(_delta: float) -> void:
	
	if !character.input.is_x():
		switch_state.emit(idle_state)
		return
		
	if character.input.is_up():
		switch_state.emit(prejump_state)
		return
	
	if character.input.is_just_pressed("dash") && character.input.is_forward():
		switch_state.emit(dash_state)
		return
	
	if character.input.is_back() && character.input.is_just_pressed("dash"):
		switch_state.emit(backdash_state)
		return
	
	if character.input.is_just_pressed("p", 6):
		character.velocity = Vector2.ZERO
		switch_state.emit(five_p_state)
		return

func physics_update(_delta: float) -> void:
	character.custom_physics()
	character.check_and_turn_around()
	
	if character.input.is_back():
		direction = "back"
	else:
		direction = "forward"
	
	character.velocity.x = (character.input.inputs[0].x
		* character.data.walk_dic.get(direction))
	
	character.anim.play(character.data.walk_animation_dic[direction])
