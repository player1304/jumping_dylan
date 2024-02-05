extends CharacterBody2D

const JUMP_VELOCITY = -250

signal increment_score

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var screensize
var sjump_elligible = true

var game_over_screen = preload("res://game_over_notification.tscn")


func _physics_process(delta):

	if is_on_floor():
		$AnimatedSprite2D.play("run")
		sjump_elligible = true
	else:
		$AnimatedSprite2D.play("jump")
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			$FirstJumpSound.play()
		elif sjump_elligible == true:
			velocity.y = JUMP_VELOCITY
			sjump_elligible = false
			$FirstJumpSound.stop()
			$SecondJumpSound.play()
		#print(get_tree().get_root().find_children("TopBlock","Object",true,false)) # this is how to connect to other scenes
	
	# detect scoring
	get_tree().get_root().find_child("ScoringArea")
	
	
	screensize = get_viewport_rect().size
	position.x = clamp(position.x, 0, screensize[0])

	move_and_slide()



func _on_hit_box_area_entered(area):
	if area.is_in_group("Obstacles"):
		print("dead")
		
		# actually ending the game
		# disabled for debug
		var p = game_over_screen.instantiate()
		$"..".add_child(p)
		get_tree().paused = true
	
	if area.is_in_group("ScoringAreas"):
		#print("score!")
		emit_signal("increment_score")
