extends CharacterBody2D


const speed = 300
var current_dir = "none"
var last_dir = "none"

func _ready():
	$AnimatedSprite2D.play("front_idle")
	self.show()

func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
		#Grid based player movement logic
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
		last_dir = "right"

	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_animation(2)
		velocity.x = 0
		velocity.y = speed
		last_dir = "down"

	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_animation(3)
		velocity.x = 0
		velocity.y = -speed
		last_dir = "up"

	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_animation(4)
		velocity.x = -speed
		velocity.y = 0
		last_dir = "left"

	else:
		play_animation(0)

		velocity.x = 0
		velocity.y = 0
	move_and_slide()

func play_animation(movement):
	var dir = current_dir
	var animation = $AnimatedSprite2D

	if dir == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
	elif dir == "down":
		animation.flip_h = false
		if movement == 2:
			animation.play("front_walk")
		elif movement == 0:
			animation.play("front_idle")
	elif dir == "up":
		animation.flip_h = false
		if movement == 3:
			animation.play("back_walk")
		elif movement == 0:
			animation.play("back_idle")
	elif dir == "left":
		animation.flip_h = true
		if movement == 4:
			animation.play("side_walk")
		elif movement == 0:
			animation.play("side_idle")
