class_name HitBox extends Area2D

var polygon: CollisionPolygon2D

var has_hit: bool
var has_hit_player: bool

var ground_hit_stun: int
var ground_pushback: Array[float]

var hit_stop: int

func _ready() -> void:
	polygon = $CollisionPolygon2D
	has_hit = false
	has_hit_player = false
	
func set_polygon(new_polygon: PackedVector2Array) -> void:
	polygon.set_polygon(new_polygon)
	
func set_character(_character: Character) -> void:
	if _character.player == "P1":
		set_collision_layer_value(Global.p1_strikes_layer, true)
	if _character.player == "P2":
		set_collision_layer_value(Global.p2_strikes_layer, true)
