extends CharacterBody2D

#  variables
var current_dir = "none"
var last_dir = "none"
var fishing = false

func _ready():
	$AnimatedSprite2D.play("idle front")
	self.position.x = 0
	self.position.y = 0
	self.show()
	
func _physics_process(delta):
	player_rotate(delta)
	gofish()
	
# move and animate ella
func player_rotate(delta):
	
	# grid based player movement logic
	if Global.fishing == false:
		if Input.is_action_pressed("ui_right"):
			$AnimatedSprite2D.flip_h = false
			current_dir = "right"
			$AnimatedSprite2D.play("idle side")

		elif Input.is_action_pressed("ui_down"):
			$AnimatedSprite2D.flip_h = false
			current_dir = "down"
			$AnimatedSprite2D.play("idle front")

		elif Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.flip_h = false
			current_dir = "up"
			$AnimatedSprite2D.play("idle back")

		elif Input.is_action_pressed("ui_left"):
			$AnimatedSprite2D.flip_h = true
			current_dir = "left"
			$AnimatedSprite2D.play("idle side")
			
		else:
			pass

func gofish():
	if Input.is_action_just_pressed("fish"):
		Global.fishing = true
		if current_dir == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("fish side")
			await get_tree().create_timer(1.1).timeout
			$AnimatedSprite2D.play("hold side")
			
		elif current_dir == "down":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("fish front")
			await get_tree().create_timer(1.1).timeout
			$AnimatedSprite2D.play("hold front")
			
		elif current_dir == "up":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("fish back")
			await get_tree().create_timer(1.1).timeout
			$AnimatedSprite2D.play("hold back")
			
		elif current_dir == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("fish side")
			await get_tree().create_timer(1.1).timeout
			$AnimatedSprite2D.play("hold side")
			
		else:
			pass
		Global.fishing = false

