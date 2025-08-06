extends Node2D

# random fish
var rng = RandomNumberGenerator.new()
var fish
var randoFish = 0

# fish vars
var fishNewPos = 0.0
@onready var botpiv = get_node("/root/world/gofish/bottom_pivot")
@onready var toppiv = get_node("/root/world/gofish/top_pivot")

var fishTimer = 0.0
var fishTargetPos = 0.0
@export var fishThinkTime = 4.0
@export var fishMoveSpeed = 5.0

# hook vars
var hookPos = 0.0
@export var hookPull = 0.5
@export var hookGravity = 0.01
@export var hookSize = 0.2
var hookVelocity = 0.0
var hookProgress = 0.0

var random = RandomNumberGenerator.new()
var isPaused = false

# signals
signal on_fish_caught
signal on_fish_process(progress)

# IMPORTANT!!!!!!!
var again = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	rando_fish()
	$catch_msg.hide()
	
	#$huh_meme.hide()
	isPaused = false
	$fish.position.y = calculate_position(0.5)
	$bar2prog.value = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if again == true:
		restart()
	# fish process
	if isPaused:
		return
	
	$countdown.value = $Timer.time_left
	$countdown.max_value = $Timer.wait_time
	
	if Input.is_action_pressed("quickfish"):
		$bar2prog.value = 100
		fish_caught()
		
	fishTimer -= delta
	if fishTimer < 0.0:
		fishTimer = fishThinkTime * random.randf()
		fishTargetPos = random.randf()

	# smoothen the movement
	$fish.position.y = lerp($fish.position.y, calculate_position(fishTargetPos), fishMoveSpeed * delta)
	#$fish.position.y = calculate_position(fishTargetPos)
	
	# hook process
	if Input.is_action_pressed("hook_pull"):
		hookVelocity += hookPull * delta
	
	hookVelocity -= hookGravity * delta
	
	hookPos += hookVelocity
	hookPos = clamp(hookPos, hookSize/2.0, 1.0 - hookSize/2.0)
	if hookPos  == hookSize/2.0 && hookVelocity < 0:
		hookVelocity = 0.0
	if hookPos == 1.0 - hookSize/2.0 && hookVelocity > 0.0:
		hookVelocity = 0.0
	
	$hook.position.y = calculate_position(hookPos)
	
	# detect progress
	var hookTopBound = $hook.position.y + hookSize/2.0
	var hookBotBound = $hook.position.y - hookSize/2.0
	
	var init_val = $bar2prog.value
	if hookBotBound < $fish.position.y && $fish.position.y < hookTopBound:
		hookProgress += 0.2
		print(hookProgress)
		emit_signal("on_fish_process", hookProgress)
		var fin_val = hookProgress * 100.0 / 1.2
		$bar2prog.value = hookProgress * 100.0 / 1.2
	
	if hookProgress > 1.0:
		fish_caught()

func rando_fish():
	$fish/blue.hide()
	$fish/clown.hide()
	$fish/star.hide()
	$fish/trash.hide()
	$fish/axolotl.hide()
	$fish/gold.hide()
	
	randoFish = rng.randi_range(0, 5)
	await get_tree().create_timer(0).timeout
	if randoFish == 0:
		$fish/blue.show()
	if randoFish == 1:
		$fish/clown.show()
	if randoFish == 2:
		$fish/star.show()
	if randoFish == 3:
		$fish/trash.show()
	if randoFish == 4:
		$fish/axolotl.show()
	if randoFish == 5:
		$fish/gold.show()
	pass

func fish_caught():
	print("fish caught")
	isPaused = true
	emit_signal("on_fish_caught")
	fish_msg()
	$catch_msg.show()
	#$huh_meme.show()
	await get_tree().create_timer(3).timeout
	$catch_msg.hide()
	#$huh_meme.hide()
	self.hide()

func fish_msg():
	if $fish/blue.visible:
		$catch_msg.set_text("you caught an idk fish! idk what type of fish that is!")
		Global.count += 1	
	if $fish/clown.visible:
		$catch_msg.set_text("you caught a clownfish! u guys both belong in a circus!")
		Global.count += 1
	if $fish/star.visible:
		$catch_msg.set_text("you caught a starfish! is this the krusty krab?")
		Global.count += 1
	if $fish/trash.visible:
		$catch_msg.set_text("you caught trash! oh dear")
	if $fish/axolotl.visible:
		$catch_msg.set_text("you caught an axolotl! prob should not be catching those")
		Global.count += 1
	if $fish/gold.visible:
		$catch_msg.set_text("you caught a goldfish! maybe ill keep it as a pet!")
		Global.count += 1
	#else:
		#$catch_msg.set_text("lol the code didn't work u get bland msg")
	
func calculate_position(normPos : float):
	normPos = 1.0 - normPos
	if is_instance_valid(botpiv):
		fishNewPos = botpiv.position.y - toppiv.position.y
		fishNewPos *= normPos
	if is_instance_valid(toppiv):
		fishNewPos += $top_pivot.position.y
	return fishNewPos

func restart():
	hookPos = 0.0
	hookVelocity = 0.0
	hookProgress = 0.0
	$bar2prog.value = 0
	$countdown.value = $Timer.wait_time
	isPaused = false
	$Timer.stop()
	$Timer.start()
	rando_fish()


func _on_timer_timeout():
	
	isPaused = true
	$Timer.stop()
	self.hide()
	again = true

