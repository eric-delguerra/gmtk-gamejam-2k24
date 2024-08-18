class_name Main extends Node2D

signal grab(fish_mass)


@onready var fish_spawn: Node2D = %FishSpawn

const FISH = preload("res://Fish/Fish.tscn")
const QTE = preload("res://QTE/QTE.tscn")
@onready var player: CharacterBody2D = %Player

var fish_ref
var fish_ref_rb


#func _process(_delta: float) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#spawn_fish(4)

func _on_spawn_ca_mord() -> void:
	print('CA MORD')
	var qte = QTE.instantiate()
	qte.qte_pressed.connect(spawn_fish)
	player.add_child(qte)

func spawn_fish(qte_value):
	var fish = FISH.instantiate()
	fish.am_eat.connect(remove_fish)
	var rb = RigidBody2D.new()
	rb.position = fish_spawn.global_position
	var colSha2d = CollisionShape2D.new()
	colSha2d.shape = CircleShape2D.new()
	
	if (qte_value == 3 or qte_value == 10):
		rb.mass = randf_range(50, 70)
	if (qte_value == 2 or qte_value == 4 or qte_value == 9 or qte_value == 11):
		rb.mass = randf_range(20, 50)
	if (qte_value == 1 or qte_value == 5 or qte_value == 8 or qte_value == 12):
		rb.mass = randf_range(2, 20)
	if (qte_value == 0 or qte_value == 6 or qte_value == 7 or qte_value == 13):
		rb.mass = randf_range(0.1, 2)
		
	colSha2d.scale *= rb.mass / randi_range(7, 9)
	colSha2d.add_child(fish)
	rb.add_child(colSha2d)
	rb.rotation = randf_range(0, TAU)
	rb.apply_central_impulse(Vector2(-350,-650 ))
	add_child(rb)
	grab.emit(rb.mass)
	fish_ref = fish
	fish_ref_rb = rb
	pass

func remove_fish():
	fish_ref_rb.queue_free()

func _on_cat_cat_has_eat() -> void:
	fish_ref.being_eat()

func _on_cat_final() -> void:
	var END_GAME = preload("res://scenes/end_game.tscn").instantiate()
	get_tree().root.add_child(END_GAME)
	pass # Replace with function body.
