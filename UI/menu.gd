extends Control

func _on_play_pressed() -> void:
	var target_color = self.modulate
	target_color.a = 0.0
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT_IN)
	tween.set_parallel()
	tween.tween_property(self, "modulate:a",target_color.a , 1.5)
	tween.play()

func _on_quit_pressed() -> void:
	get_tree().quit()
