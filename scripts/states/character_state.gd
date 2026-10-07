class_name CharacterState extends State

signal hit_stop_end

var character: Character

func _ready() -> void:
	character = get_parent().get_parent()
