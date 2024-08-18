extends AnimatedSprite2D

signal cat_has_eat()
signal final()

const LOVE = preload("res://Particules/Love.tscn")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

const CAT_01 = preload("res://Sounds/cat-01.mp3")
const CAT_02 = preload("res://Sounds/cat-02.mp3")
const CAT_03 = preload("res://Sounds/cat-03.mp3")
const CAT_04 = preload("res://Sounds/cat-04.mp3")
const CAT_05 = preload("res://Sounds/cat-05.mp3")

const ANIMATED_LABEL = preload("res://UI/AnimatedLabel.tscn")

var need_to_grow = false
var fish_mass = 0

var player_contact = false

var _final = false

func _ready() -> void:
	play_sound()

func _process(_delta: float) -> void:
	if player_contact:
		if(Input.is_action_just_pressed("ui_accept")):
			var label = ANIMATED_LABEL.instantiate()
			label.text = "Meeeeooooww !"
			label.scale *= .6
			label.position = Vector2(-35, -60) 
			add_child(label)
			var particles = LOVE.instantiate()
			add_child(particles)
			particles.one_shot = true
			particles.emitting = true
			particles.amount = randi_range(3, 5)
			particles.global_position.y = global_position.y - 30
	
	if scale.y > 12 and !_final:
		_final = true
		final.emit()
	
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
	print(str(res))
	var new_scale 
	if res < 1:
		new_scale = scale - Vector2(res, res)
	else:
		new_scale = scale + Vector2(res, res)
		 
	tween.tween_property(
		self,
		"scale",
		new_scale,
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
		player_contact = true
		play_sound()

func play_sound():
	var rand = randf()
	if (rand < .2):
		audio_stream_player_2d.stream = CAT_01
	elif (rand < .4):
		audio_stream_player_2d.stream = CAT_02
	elif (rand < .6):
		audio_stream_player_2d.stream = CAT_03
	elif (rand < .8):
		audio_stream_player_2d.stream = CAT_04
	elif (rand < 1):
		audio_stream_player_2d.stream = CAT_05
	
	audio_stream_player_2d.play()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.name == 'Player'):
		player_contact = false
