extends Node

const ANIMATED_LABEL = preload("res://UI/AnimatedLabel.tscn")

var fisherman_phrases_en = [
	"Let's hope for a big catch tonight, but with my luck, it'll be seaweed again!",
	"I swear, it's colder than a penguin's toes out here. Good thing I've got my lucky hat!",
	"Did I just see a shadow, or is the fish playing tricks on me?",
	"Shh, you’ll scare the fish! Or maybe that’s just my excuse for catching nothing...",
	"I wonder if the fish are sleeping or just avoiding me.",
	"This rod better not break again, or I'll be fishing with a stick!",
	"Another night, another chance to prove that I'm not the worst fisherman around!",
	"Why do I keep hearing that cat? I swear it's plotting against me!",
	"The stars are out, the night is calm... perfect time for my bait to fall off!"
]

var last_phrase_en = "If that sneaky cat steals one more fish, I'm switching to dog food!"


func wait(time = 2) -> Timer:
	var timer = Timer.new()
	timer.wait_time = time
	timer.autostart = true
	timer.one_shot = true
	return timer

func animated_label(text: String, text_time = 1.5, free_time = 2.5) -> AnimatedLabel:
	var an_label = ANIMATED_LABEL.instantiate()
	an_label.text = text
	an_label.free_time = free_time
	an_label.text_time = text_time
	return an_label
	
func random_phrase():
	return fisherman_phrases_en[randi() % fisherman_phrases_en.size()]
