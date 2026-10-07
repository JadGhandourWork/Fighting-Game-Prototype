extends CharacterState

@export var idle_state: State

var remaining: int

func enter_state() -> void:
	remaining = character.data.backdash_duration
	character.anim.play("Backdash")
	character.velocity.x = (character.directions.find_key("back")
		* character.data.backdash_speed)

func update(_delta: float) -> void:
	if remaining < 1:
		switch_state.emit(idle_state)
		return

func physics_update(_delta: float) -> void:
	character.custom_physics()
	remaining -= 1
