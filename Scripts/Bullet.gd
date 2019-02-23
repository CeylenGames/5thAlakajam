extends KinematicBody2D

var velocity = Vector2()
var Speed = 250

func _ready():
	var angle = velocity.angle()
	rotation += angle

func _physics_process(delta):
	move_and_slide(velocity * Speed * delta)
