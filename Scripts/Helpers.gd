extends Node

func wait(time = 2) -> Timer:
	var timer = Timer.new()
	timer.wait_time = time
	timer.autostart = true
	timer.one_shot = true
	return timer
