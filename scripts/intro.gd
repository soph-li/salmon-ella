extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	#$gramps_talk.play()
	$transition.play("fade_in")
	$beachweek.play("crab")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_skip_pressed():
	get_tree().change_scene_to_file("res://scenes/world.tscn")
