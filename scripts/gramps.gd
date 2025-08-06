extends Sprite2D

@onready var speech_sound = preload("res://audio/tapsound.wav")

var dlk = 0

const lines: Array[String] = [
	"Hello! You must be Ella! (press enter to continue)",
	"It is up to you to continue your family's fishing business.",
	"Use arrow keys to explore the beach. Aren't the waves fantastic?",
	"......",
	"You don't know how to fish?!?!?",
	"Gosh!!!!",
	"......",
	"Press 'F' to fish, and arrow keys to rotate. ",
	"Once a fish bites, keep the hook around the fish until the fish is caught! Do this by left-clicking with your mouse/trackpad.",
	"Simple enough... right?",
	"... well it's your fault for not knowing how to fish.",
	"Oops! Onto the boat you go!"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	DialogManager.start_dialog(global_position, lines, speech_sound)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DialogManager.current_line_index == 11:
		await get_tree().create_timer(3).timeout
		get_tree().change_scene_to_file("res://scenes/world.tscn")

