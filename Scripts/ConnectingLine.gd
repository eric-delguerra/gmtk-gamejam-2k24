class_name ConnectingLine
extends Line2D

var start_point: Vector2
var end_point: Vector2

func _init(start: Vector2, end: Vector2):
	start_point = start
	end_point = end
	points = [start_point, end_point]
	width = 2
	default_color = Color.WHITE

func update_end_point(new_end: Vector2):
	end_point = new_end
	points[1] = end_point
