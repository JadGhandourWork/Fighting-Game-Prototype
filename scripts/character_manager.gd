class_name CharacterManager extends Node2D

var character1: Character
var character2: Character

func _ready() -> void:
	Global.attack.connect(reorder_characters)
	
	var character_scene = load("res://scenes/character.tscn")
	
	character1 = character_scene.instantiate()
	character2 = character_scene.instantiate()
	
	character1.name = "Character1"
	character2.name = "Character2"
	
	character1.player = "P1"
	character2.player = "P2"
	
	character1.opponent = character2
	character2.opponent = character1
	
	character1.data = Global.inaba_data
	character2.data = Global.inaba_data
	
	character1.position.x = -Global.roundstart_distance
	character2.position.x = Global.roundstart_distance
	
	add_child(character1)
	add_child(character2)

func reorder_characters(player: String):
	if player == "P1":
		character1.z_index = 1
		character2.z_index = 0
	if player == "P2":
		character2.z_index = 1
		character1.z_index = 0
