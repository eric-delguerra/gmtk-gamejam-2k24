extends AnimatedSprite2D

signal cat_has_eat()

const LOVE = preload("res://Particules/Love.tscn")

var need_to_grow = false
var fish_mass = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func _physics_process(_delta: float) -> void:
	if(need_to_grow):
		need_to_grow = false
		adjust_scale_and_position()


func _on_main_grab(fish_mass_props) -> void:
	fish_mass = fish_mass_props
	var rand = randi_range(1, 2)
	var timer = Helpers.wait(rand)
	timer.timeout.connect(func():
		play('Eat')
		timer.queue_free()
		wait(rand)
	)
	add_child(timer)
	
func wait(time):
	var timer = Helpers.wait(time)
	timer.timeout.connect(func():
		eat()
		timer.queue_free()
	)
	add_child(timer)

func eat():
	play('Idle') 
	cat_has_eat.emit()
	need_to_grow = true
	
func adjust_scale_and_position():
	var res = calculate_scale_from_mass(fish_mass)
	var tween = get_tree().create_tween()
	tween.tween_property(
		self,
		"scale",
		Vector2(res, res),
		1.5,
	)
	tween.play()

func calculate_scale_from_mass(mass: float, min_scale: float = 0.5, max_scale: float = 3.0) -> float:
	var min_mass = 0.1
	var max_mass = 70.0

	# Normaliser la masse entre 0 et 1
	var normalized_mass = (mass - min_mass) / (max_mass - min_mass)

	# Calculer l'échelle en fonction de la masse normalisée
	return lerp(min_scale, max_scale, normalized_mass)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.name == 'Player'):
		var particles = LOVE.instantiate()
		add_child(particles)
		particles.one_shot = true
		particles.emitting = true
		particles.amount = randi_range(3, 5)
		particles.global_position.y = global_position.y - 30
		print('playeur')
