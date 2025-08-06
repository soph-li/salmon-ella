extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$beachweek.play("crab") # Replace with function body.
	#$ella_speech.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#$title.scale = lerp($title.scale, calculate_position(fishTargetPos), fishMoveSpeed * delta)
	pass

func _on_play_pressed():
	if Global.first_load == true:
		get_tree().change_scene_to_file("res://scenes/intro.tscn")
		Global.first_load = false
	else:
		get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_quit_pressed():
	get_tree().quit()
