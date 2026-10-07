class_name HurtBox extends Area2D

var polygon: CollisionPolygon2D
var character: Character

func _ready() -> void:
	polygon = $CollisionPolygon2D
	character = get_parent()
	if (character.player) == "P1":
		set_collision_layer_value(Global.p1_hurt_box_layer, true)
		set_collision_mask_value(Global.p2_strikes_layer, true)
	if (character.player) == "P2":
		set_collision_layer_value(Global.p2_hurt_box_layer, true)
		set_collision_mask_value(Global.p1_strikes_layer, true)

func set_polygon(new_polygon: PackedVector2Array) -> void:
	polygon.set_polygon(new_polygon)

func _on_hitbox_entered(hitbox: Area2D) -> void:
	hitbox.has_hit = true
	hitbox.has_hit_player = true
	character.state_machine.got_hit.emit(hitbox)
