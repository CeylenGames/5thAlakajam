extends KinematicBody2D

export (float) var Speed = 100
var velocity = Vector2()

func _process(delta):
	velocity = Vector2()
	get_events(delta)
	move_and_slide(velocity)

func get_events(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += Speed
		$AnimatedSprite.play("Face")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= Speed
		$AnimatedSprite.play("Face")
	if Input.is_action_pressed("ui_up"):
		velocity.y -= Speed
		$AnimatedSprite.play("Dos")
	if Input.is_action_pressed("ui_down"):
		velocity.y += Speed
		$AnimatedSprite.play("Face")
