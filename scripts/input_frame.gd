class_name InputFrame extends Node

var x: float
var y: float
var dash: bool
var p: bool

func _init(_x: float = 0, _y: float = 0, _dash: bool = false, _p: bool = false):
	x = _x
	y = _y
	dash = _dash
	p = _p

func _to_string() -> String:
	return ("x: " + str(x) + " | "
	+ "y: " + str(y) + " | "
	+ "dash: " + str(dash) + " | "
	+ "P: " + str(p))
	
