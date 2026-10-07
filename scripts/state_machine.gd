class_name StateMachine extends Node

signal got_hit(hit_box: HitBox)

@export var initial_state: State
@export var stand_hit_stun: State
@export var air_hit_stun: State

var character: Character

var active_state: State
var hit_stop: int = -1

var airborne: bool = false

func _ready() -> void:
	character = get_parent()
	
	got_hit.connect(on_hit)
	
	for child_state: State in get_children():
		child_state.switch_state.connect(change_state)
	
	change_state(initial_state)

func _process(delta: float) -> void:
	active_state.update(delta)
	
func _physics_process(delta: float) -> void:
	if hit_stop > 0:
		hit_stop -= 1
	else:
		hit_stop = -1
		active_state.hit_stop_end.emit()
		active_state.physics_update(delta)

func change_state(new_state: State) -> void:
	if active_state:
		active_state.exit_state()
	active_state = new_state
	
	if active_state:
		active_state.enter_state()
		
func on_hit(hit_box: HitBox) -> void:
	
	if airborne:
		on_air_hit(hit_box)
	else:
		on_ground_hit(hit_box)

func on_ground_hit(hit_box: HitBox) -> void:
	stand_hit_stun.duration = hit_box.ground_hit_stun
	change_state(stand_hit_stun)
	
	var hit_box_hit_stop = hit_box.hit_stop
	
	character.opponent.state_machine.hit_stop = hit_box_hit_stop
	character.opponent.anim.hit_stop.emit(hit_box_hit_stop)
	
	hit_stop = hit_box_hit_stop
	character.anim.hit_stop.emit(hit_box_hit_stop)
	
	character.push_box.pushback_to_apply = []
	for i in hit_box.ground_pushback:
		character.push_box.pushback_to_apply.append(i)

func on_air_hit(hit_box: HitBox) -> void:
	change_state(air_hit_stun)
	
	var hit_box_hit_stop = hit_box.hit_stop
	
	character.opponent.state_machine.hit_stop = hit_box_hit_stop
	character.opponent.anim.hit_stop.emit(hit_box_hit_stop)
	
	hit_stop = hit_box_hit_stop
	character.anim.hit_stop.emit(hit_box_hit_stop)
