extends Area2D

var velocity = Vector2()
var Speed = 250

func _ready():
	var angle = velocity.angle()
	rotation = angle + PI/2

func _physics_process(delta):
	position.x += velocity.x * Speed * delta
	position.y += velocity.y * Speed * delta
