class_name AnimatedLabel extends Label

@export var text_time: float = 1.5 
@export var free_time: float = 2.5 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible_ratio = 0
	var tween = get_tree().create_tween() 
	tween.tween_property(
		self,
		"visible_ratio",
		1,
		text_time,
	)
	tween.play()
	tween.finished.connect(func() : 
		var time = Helpers.wait(free_time)
		time.timeout.connect(func(): 
			fade_out()
		)
		add_child(time))
	

func fade_out():
	var tween = get_tree().create_tween() 
	tween.tween_property(
		self,
		"visible_ratio",
		0,
		text_time / 2,
	)
	tween.play()
	tween.finished.connect(func() : 
		var time = Helpers.wait(free_time)
		time.timeout.connect(func(): 
			queue_free()
		)
		add_child(time)
	)
