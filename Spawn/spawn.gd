extends Area2D

signal ca_mord()

@export var spawn_scene: PackedScene 
var spawned_items = []

func spawn_item():
	var collision_shape = get_node("CollisionShape2D")
	var shape = collision_shape.shape
	
	var spawn_position = Vector2.ZERO
	
	if shape is RectangleShape2D:
		var extents = shape.extents
		spawn_position = Vector2(
			randf_range(-extents.x, extents.x),
			randf_range(-extents.y, extents.y)
		)
	elif shape is CircleShape2D:
		var angle = randf() * 2 * PI
		var radius = randf() * shape.radius
		spawn_position = Vector2(cos(angle) * radius, sin(angle) * radius)
	
	# Ajustez la position en fonction de la position globale de l'Area2D
	spawn_position += global_position
	
	# Instanciez l'objet
	var instance = spawn_scene.instantiate()
	instance.global_position = spawn_position
	get_parent().add_child(instance)
	spawned_items.append(instance)
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = true
	timer.wait_time = randf_range(4, 12)
	timer.timeout.connect(func():
		ca_mord.emit()
		timer.queue_free()
	)
	add_child(timer)

func _on_player_phising() -> void:
	spawn_item()


func _on_player_touche() -> void:
	var item = spawned_items[0]
	spawned_items.remove_at(0)
	item.queue_free()	
	pass # Replace with function body.
