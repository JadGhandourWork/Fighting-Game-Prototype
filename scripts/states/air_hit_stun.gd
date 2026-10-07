extends CharacterState

@export var landing_state: State

var current_frame: int
var minimum_duration: int

func enter_state() -> void:
	character.velocity = Vector2.ZERO
	current_frame = 1
	character.anim.play("Hit Air")
	character.anim.queue("Hit Air Fall")
	
func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	character.velocity.y += Global.juggle_gravity
	
	if character.custom_physics():
		if character.get_last_slide_collision().get_collider().get_collision_layer() == 1:
			switch_state.emit(landing_state)
	current_frame += 1

func exit_state() -> void:
	character.anim.stop()
