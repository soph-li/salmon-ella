extends Node2D
var volTurn # high - mute - low

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.fish_again = false
	$gofish.hide()
	$serene.play("default")
	$transition.play("fade_in")
	$volume.play("high_vol")
	volTurn = 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$count.text = str(Global.count)
	if Global.fishing == true:
		#$gofish.rando_fish()
		await get_tree().create_timer(1).timeout
		$gofish.show()
		Global.fish_again = true
	if Global.fish_again == true && Global.fishing == true:
		#$gofish.rando_fish()
		$gofish.restart()
		$gofish.show()
	change_volume()
		
func change_volume():
	if volTurn == 0:
		$volume.play("mute")
		$dj.volume_db = -10000000000
		$"now playing".hide()
	if volTurn == 1:
		$volume.play("low_vol")
		$dj.volume_db = -12
		$"now playing".show()
	if volTurn == 2:
		$volume.play("high_vol")
		$dj.volume_db = 0
		$"now playing".show()

func _on_volume_button_pressed():
	volTurn += 1
	if volTurn > 2:
		volTurn = 0


func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
