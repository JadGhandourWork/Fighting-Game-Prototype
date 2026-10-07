extends CharacterState

@export var idle_state: State

var current_frame: int
var duration: int

func enter_state() -> void:
	character.velocity = Vector2.ZERO
	current_frame = 1
	character.anim.play("Hit Weak")
	
func update(_delta: float) -> void:
	if duration - current_frame < character.data.weak_hit_exit_duration:
		character.anim.play("Hit Weak Exit")
	
	if current_frame > duration:
		switch_state.emit(idle_state)
		return
	
func physics_update(_delta: float) -> void:
	character.custom_physics()
	current_frame += 1

func exit_state() -> void:
	character.anim.stop()
