extends AnimatedSprite2D
signal qte_pressed(value)

const FISH_JUMPING_SPLASH_1 = preload("res://Sounds/fish-jumping-splash-1.mp3")
const FISH_JUMPING_SPLASH_2 = preload("res://Sounds/fish-jumping-splash-2.mp3")
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rand = randf()
	if (rand < .5):
		audio_stream_player.stream = FISH_JUMPING_SPLASH_1
	else:
		audio_stream_player.stream = FISH_JUMPING_SPLASH_2
	audio_stream_player.play()
	frame = absi(rand * 10)
	speed_scale += rand
	play("qte_forward")
	var timer = Helpers.wait(3.5)
	timer.timeout.connect(func():
		qte_pressed.emit(0)
		queue_free()
	)
	add_child(timer)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed_scale += delta * 0.2
	
	if Input.is_action_just_pressed("ui_accept"):
		qte_pressed.emit(frame)
		queue_free()
	
func _init() -> void:
	pass
