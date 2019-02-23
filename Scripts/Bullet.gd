extends Area2D

var velocity = Vector2()
var Speed = 250

func _ready():
	var angle = velocity.angle()
	rotation = angle + PI/2

func _physics_process(delta):
	position.x += velocity.x * Speed * delta
	position.y += velocity.y * Speed * delta


func _on_body_entered(body):
	if body.is_in_group("Enemy"):
		body.leave_coin()
		queue_free()
