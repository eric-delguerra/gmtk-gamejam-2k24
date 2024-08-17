extends AnimatedSprite2D
signal qte_pressed(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play("qte_forward")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	speed_scale += delta * 0.2
	
	if Input.is_action_just_pressed("ui_accept"):
		qte_pressed.emit(frame)
		queue_free()
	
func _init() -> void:
	pass
