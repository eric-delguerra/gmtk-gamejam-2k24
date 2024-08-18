extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Engine.time_scale = 0.1


func _on_play_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.set_parallel()
	tween.tween_property(self, "zoom", Vector2(1, 1), 1.5)
	tween.tween_property(self, "offset", Vector2(0, 0), 1.5)
	tween.play()
	Engine.time_scale = 1.0

	
