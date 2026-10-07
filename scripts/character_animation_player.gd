class_name CharacterAnimationPlayer extends AnimationPlayer

signal hit_stop(duration: int)

var remaining_hit_stop: int = -1

var stocked_queue: Array

func _ready():
	hit_stop.connect(apply_hit_stop)
	
func _physics_process(_delta: float) -> void:
	
	if remaining_hit_stop > 0:
		remaining_hit_stop -= 1
	elif remaining_hit_stop == 0:
		play()
		for anim in stocked_queue:
			queue(anim)
		remaining_hit_stop = -1

func apply_hit_stop(duration: int):
	remaining_hit_stop = duration
	stocked_queue = get_queue()
	pause()
	advance(0)
