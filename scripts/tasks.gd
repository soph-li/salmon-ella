extends Node2D
var scrollOut
var first

# Called when the node enters the scene tree for the first time.
func _ready():
	scrollOut = 0
	first = 5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

	
func _on_button_pressed():
	if first == 5:
		$rollout.play("roll_out")
		scrollOut += 1
		first = 10
	else:
		
		if scrollOut == 1:
			$rollout.play("roll_in")
		if scrollOut == 0:
			$rollout.play("roll_out")
			
		scrollOut += 1
		if scrollOut > 1:
			scrollOut = 0
