extends CharacterBody2D

signal phising()
signal touche()


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var can_fish = false
var is_phising = false
var is_locked = false
var last_fishin = false


@onready var space_button_animation: AnimatedSprite2D = %SpaceButtonAnimation
@onready var player_animation: AnimatedSprite2D = %PlayerAnimation
@onready var phising_animation: AnimatedSprite2D = %PhisingAnimation
@onready var text_spawn: Node2D = $TextSpawn


func _ready() -> void:
	space_button_animation.visible = false
	player_animation.play('Idle')
	
func _process(_delta: float) -> void:
	
	if(can_fish and !is_phising):
		if Input.is_action_just_pressed("ui_accept") and is_on_floor():
			is_phising = true
			fish()

func fish():
	is_locked = true
	space_button_animation.visible = false
	var text 
	if (last_fishin):
		text = Helpers.animated_label(Helpers.last_phrase_en, 2.5, 4)
	else:
		text = Helpers.animated_label(Helpers.random_phrase(), 2.5, 4)
		
	text.position = text_spawn.position
	text.scale *= .6
	add_child(text)
	phising_animation.play('Throw')
	phising_animation.animation_finished.connect(func ():
		phising.emit()
		print('is fishing'),
		CONNECT_ONE_SHOT
	)

func grab():
	phising_animation.play('Fish')
	phising_animation.animation_finished.connect(func ():
		is_phising = false
		is_locked = false
		touche.emit()
		phising_animation.play('Idle'),
		CONNECT_ONE_SHOT
	)

func _physics_process(delta: float) -> void:
	if is_phising:
		return
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		player_animation.play('Walk')
		velocity.x = direction * SPEED
		if (direction < 0):
			player_animation.flip_h = true
		else:
			player_animation.flip_h = false
	else:
		player_animation.play('Idle')
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func unlock():
	is_locked = false

func _on_fishing_body_entered(body: Node2D) -> void:
	if	(body == self):
		can_fish = true
		space_button_animation.visible = true
		space_button_animation.play('Press')

func _on_fishing_body_exited(body: Node2D) -> void:
	if	(body == self):
		can_fish = false
		space_button_animation.visible = false
		space_button_animation.stop()


func _on_main_grab(_fish_mass) -> void:
	grab()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body == self):
		space_button_animation.visible = true
		space_button_animation.play('Press')


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body == self):
		space_button_animation.visible = false
		space_button_animation.stop()


func _on_cat_final() -> void:
	last_fishin = true
