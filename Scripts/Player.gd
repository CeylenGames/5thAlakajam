extends KinematicBody2D

# Movement
export (float) var Speed = 300
var velocity = Vector2()

export (PackedScene) var Combo_Indic
export (Vector2) var Combo_Indic_Pos

export (PackedScene) var Bullet
export (Texture) var select_texture

var bodies = Array()
var selected

var coins = 0

func _ready():
	randomize()

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		BeginCombo()
	# Movement
	velocity = Vector2()
	get_events(delta)
	move_and_slide(velocity)

func get_events(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x += Speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Side")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= Speed
		$AnimatedSprite.play("Side")
		$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_up"):
		velocity.y -= Speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Dos")
	if Input.is_action_pressed("ui_down"):
		velocity.y += Speed
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("Face")
	
	if Input.is_action_just_pressed("select_enemy"):
		choose_a_guy()
		
func BeginCombo():
	var combo = Combo_Indic.instance()
	add_child(combo)
	combo.position = Combo_Indic_Pos
	combo.connect("combo_ended", self, "end_combo")
	combo.begin(10)

func end_combo():
	if selected:
		var bullet = Bullet.instance()
		bullet.position = get_node("../Player").position
		bullet.velocity = (selected.position - position).normalized()
		get_node("../../World").add_child(bullet)

func _detected(body):
	if body.is_in_group("Enemy"):
		bodies.append(body)
	elif body.is_in_group("Coin"):
		coins += 1
		body.queue_free()

func _undetected(body):
	if body.is_in_group("Enemy"):
		bodies.remove(bodies.find(body))
	if body == selected:
		body.get_node("Selector").queue_free()
		selected = null

func choose_a_guy():
	if bodies.size() > 0:
		var node = bodies[rand_range(0, bodies.size())]
		var sprite = Sprite.new()
		sprite.name = "Selector"
		node.add_child(sprite)
		sprite.texture = select_texture
		selected = node