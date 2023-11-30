extends Node2D

func _draw() -> void:
	if Global.seedRandomized:
		seed(int(Time.get_unix_time_from_system() * 1000))
	else:
		seed(Global.seedValue)

	var color: Color = Color.black
	if Global.preset == 3:
		for x in range(0, 256):
			for y in range(0, 256):
				color.r = pow(rand_range(0.0, 1.0), 3.0)
				color.g = color.r
				color.b = color.r
				draw_rect(Rect2(x, y, 1, 1), color)
	else:
		for x in range(96, 96+64):
			for y in range(96, 96+64):
				color.r = pow(rand_range(0.0, 1.0), 3.0)
				color.g = color.r
				color.b = color.r
				draw_rect(Rect2(x, y, 1, 1), color)
