extends Control

const CAT_02 = preload("res://Sounds/cat-02.mp3")
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_stream_player_2d.stream = CAT_02
	audio_stream_player_2d.play()


func _on_texture_button_pressed() -> void:
	var current_scene = get_tree().current_scene
	get_tree().reload_current_scene()
