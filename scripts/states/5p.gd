extends CharacterState

@export var idle_state: State

var current_frame: int
var hit_box: HitBox = load("res://scenes/hit_box.tscn").instantiate()
var has_hit: bool
var released_p: bool

func enter_state() -> void:
	Global.attack.emit(character.player)
	
	current_frame = 1
	has_hit = false
	released_p = false
	
	character.hurt_box.set_polygon(character.data.five_p_hurt_box_1)
	character.anim.play("5P")
	
	reset_hit_box()

func update(_delta: float) -> void:
	if current_frame > character.data.five_p_duration:
		switch_state.emit(idle_state)
		return
	
	if hit_box.has_hit:
		has_hit = true
	
	if !character.input.is_p() && released_p == false:
		released_p = true
		character.input.clear_specific_input("p")
	
	if released_p && has_hit && character.input.is_just_pressed("p", 10):
		await hit_stop_end
		switch_state.emit(self)
		return
	
	if !frame_computed:
		if current_frame == character.data.five_p_hurt_box_2_frame:
			character.hurt_box.set_polygon(character.data.five_p_hurt_box_2)
		
		if current_frame == character.data.five_p_hurt_box_3_frame:
			character.hurt_box.set_polygon(character.data.five_p_hurt_box_3)
			pass
	
		if current_frame == character.data.five_p_hit_box_frame:
			
			hit_box.set_character(character)
			hit_box.ground_hit_stun = character.data.five_p_hit_stun
			hit_box.hit_stop = character.data.five_p_hit_stop
			hit_box.ground_pushback = character.data.five_p_ground_pushback
			
			character.add_child(hit_box)
			hit_box.set_polygon(character.data.five_p_hit_box)
	
		if current_frame == character.data.five_p_hit_box_end_frame:
			reset_hit_box()
		
		frame_computed = true
		
func exit_state() -> void:
	reset_hit_box()
	character.anim.stop()

func physics_update(_delta: float) -> void:
	character.velocity.x *= character.data.dash_stop_friction
	
	character.custom_physics()
	
	current_frame += 1
	frame_computed = false
	
func reset_hit_box() -> void:
	hit_box.queue_free()
	hit_box = load("res://scenes/hit_box.tscn").instantiate()
	
