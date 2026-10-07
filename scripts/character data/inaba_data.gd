class_name InabaData extends Node

const forward_walk_speed: float = 180
const back_walk_speed: float = 130
const walk_dic = {"forward" : forward_walk_speed, "back" : back_walk_speed}
const walk_animation_dic = {"forward" : "Walk Forward", "back" : "Walk Back"}

const prejump: int = 4
const jump_velocity: float = -1050
const gravity: float = 40
const jump_animation_dic = {"forward" : "Jump Forward", "back" : "Jump Back"}
const airborne_animation_dic = {"forward" : "Airborne Forward", "back" : "Airborne"}
const max_neutral_jump_velocity = 130
const landing: int = 2

const initial_dash_speed: float = 200
const max_dash_speed: float = 500
const dash_acceleration: float = 1.05
const dash_stop_duration: int = 32
const dash_stop_cancel: int = 5
const dash_stop_friction: float = 0.8
const dash_backdash_cancel: int = 4

const backdash_duration: int = 18
const backdash_speed: float = 300

const idle_hurt_box: PackedVector2Array = [
	Vector2(12.5,0),
	Vector2(12.5,-76.0),
	Vector2(-12.5, -76),
	Vector2(-12.5, 0),
]

const five_p_duration = 13

const five_p_hurt_box_1: PackedVector2Array = [
	Vector2(12.5,0),
	Vector2(12.5,-76.0),
	Vector2(-12.5, -76),
	Vector2(-12.5, 0),
]

const five_p_hurt_box_2_frame = 4
const five_p_hurt_box_2: PackedVector2Array = [
	Vector2(33, 0),
	Vector2(33, -10),
	Vector2(28, -10),
	Vector2(28, -76),
	Vector2(1, -76),
	Vector2(1, -47),
	Vector2(-5, -47),
	Vector2(-5, -18),
	Vector2(-12, -18),
	Vector2(-12, 0)
]

const five_p_hurt_box_3_frame = 5
const five_p_hurt_box_3: PackedVector2Array = [
	Vector2(37, 0),
	Vector2(37, -46),
	Vector2(57, -46),
	Vector2(57, -76),
	Vector2(1, -76),
	Vector2(1, -47),
	Vector2(-5, -47),
	Vector2(-5, -18),
	Vector2(-12, -18),
	Vector2(-12, 0)
]

const five_p_hit_box_frame = 5
const five_p_hit_box: PackedVector2Array = [
	Vector2(56, -74),
	Vector2(56, -50),
	Vector2(16, -50),
	Vector2(16, -74),
]
const five_p_hit_box_end_frame = 8

const five_p_hit_stun = 10
const five_p_hit_stop = 8

const five_p_ground_pushback: Array[float] = [4,4,4,4,4,4]


const weak_hit_exit_duration = 9
