class_name FishEatParticules extends AnimatedSprite2D

signal am_eat()

const FISH_EAT_PARTICULES = preload("res://Particules/FishEatParticules.tscn")
var is_eat = false


func _physics_process(_delta: float) -> void:
	if (is_eat):
		is_eat = false
		var tween = get_tree().create_tween()
		tween.tween_property(
			self,
			"scale",
			Vector2.ZERO,
			1.2,
		)
		tween.play()
		tween.finished.connect(func():
			am_eat.emit()
		)
		

func _init() -> void:
	frame = randi_range(0, sprite_frames.get_frame_count('default') - 2)

func being_eat():
	var particles = FISH_EAT_PARTICULES.instantiate()
	add_child(particles)
	particles.one_shot = true
	particles.emitting = true
	self_modulate.a = 0
	var timer = Helpers.wait(2)
	timer.timeout.connect(func() :
		particles.queue_free()
		self_modulate.a = 1
		frame = sprite_frames.get_frame_count('default') - 1
		is_eat = true
	)
	add_child(timer)
	
