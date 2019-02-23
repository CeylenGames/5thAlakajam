extends KinematicBody2D

var is_ready = false

var nav_node
var player

var path

var index = 0
var vector = Vector2()
var Speed = 200

export (PackedScene) var Coin

func _physics_process(delta):
	if is_ready:
		move(delta)
		
func set_nav(nav, pl):
	nav_node = nav
	player = pl
	path =  get_path()
	is_ready = true

func move(delta):
	if index != 0:
		var vector = path[index] - path[index-1]
		vector = vector.normalized()
		move_and_slide(vector * Speed)
	else:	
		var vector = -path[index].normalized()
	if vector == Vector2():
		if index != path.size() - 1:
			index += 1
		else:
			path = get_path()
	move_and_slide(vector * Speed)

func get_path():
	return nav_node.get_simple_path(position, player.position)
	
func set_sprite(texture):
	$Sprite.texture = texture

func _on_body_entered(body):
	if body.is_in_group("Bullet"):
		body.queue_free()
		var coin = Coin.instance()
		coin.position = position
		body.parent.add_child(coin)
		queue_free()
