class_name Character extends CharacterBody2D

var player: String
var opponent: Character
var data: Node

var directions = {1.0 : "forward", -1.0 : "back"}

var anim: CharacterAnimationPlayer
var input: InputManager
var push_box: CharacterPushBox
var hurt_box: HurtBox
var state_machine: StateMachine

func _enter_tree() -> void:
	input = $InputManager
	anim = $CharacterAnimationPlayer
	push_box = $PushBox
	hurt_box = $HurtBox
	state_machine = $StateMachine
	
func custom_physics() -> bool:
	var _move_and_slide = move_and_slide()
	if (player == "P2"):
		push_box.check_collisions()
	push_box.apply_pushback()
	return _move_and_slide
	
func check_and_turn_around():
	if position.direction_to(opponent.position).x * directions.find_key("forward") < 0:
		directions = {1.0 : directions.get(-1.0), -1.0 : directions.get(1.0)}
		scale.x *= -1
