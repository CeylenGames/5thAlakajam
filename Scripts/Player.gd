extends KinematicBody2D

# Movement
export (float) var Speed = 300
var velocity = Vector2()

export (PackedScene) var Combo_Indic

var is_comboting = false

export (PackedScene) var Bullet
export (Texture) var select_texture

var bodies = Array()
var selected

export (NodePath) var Coins
var coins = 1000

export (NodePath) var ChargeBar
var charge_max = 100
var charge = charge_max

var charge_loose = 10

var bar_lvl = 1

func _ready():
	load_data()
	updateUi()
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
		if not $AnimatedSprite.animation in ["Face", "Dos"]:
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("Side")
	if Input.is_action_pressed("ui_left"):
		velocity.x -= Speed
		if not $AnimatedSprite.animation in ["Face", "Dos"]:
			$AnimatedSprite.play("Side")
			$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("ui_up"):
		velocity.y -= Speed
		if not $AnimatedSprite.animation in ["Face", "Side"]:
			$AnimatedSprite.play("Dos")
			$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("ui_down"):
		velocity.y += Speed
		if not $AnimatedSprite.animation in ["Dos", "Side"]:
			$AnimatedSprite.play("Face")
			$AnimatedSprite.flip_h = false
	
	if Input.is_action_just_released("ui_right"):
		$AnimatedSprite.play("SideIdle")
	if Input.is_action_just_released("ui_left"):
		$AnimatedSprite.play("SideIdle")
	if Input.is_action_just_released("ui_down"):
		$AnimatedSprite.play("FaceIdle")
	if Input.is_action_just_released("ui_up"):
		$AnimatedSprite.play("DosIdle")
	
	if Input.is_action_just_pressed("select_enemy"):
		choose_a_guy()
		
func BeginCombo():
	if not is_comboting:
		var combo = Combo_Indic.instance()
		$ComboReceptor.add_child(combo)
		combo.connect("combo_ended", self, "end_combo")
		combo.begin(3)
		is_comboting = true

func end_combo():
	if selected and charge >= charge_loose:
		var bullet = Bullet.instance()
		bullet.position = get_node("../Player").position
		bullet.velocity = (selected.position - position).normalized()
		get_node("../../World").add_child(bullet)
		
		charge -= charge_loose
		updateUi()
	is_comboting = false

func _detected(body):
	if body.is_in_group("Enemy"):
		bodies.append(body)

func _undetected(body):
	if body.is_in_group("Enemy"):
		bodies.remove(bodies.find(body))
	if body == selected:
		body.get_node("Selector").queue_free()
		selected = null

func choose_a_guy():
	if bodies.size() > 0 and not selected:
		var node = bodies[rand_range(0, bodies.size())]
		var sprite = Sprite.new()
		sprite.name = "Selector"
		sprite.apply_scale(Vector2(0.15, 0.15))
		sprite.position = Vector2(0, -80)
		node.add_child(sprite)
		sprite.texture = select_texture
		selected = node

func coin_pick(body):
	if body.is_in_group("Coin"):
		coins += 1
		body.get_parent().queue_free()
		updateUi()

func updateUi():
	get_node(ChargeBar).value = charge
	get_node(Coins).text = str(coins)
	if charge == 0:
		get_tree().change_scene("res://LooseMenu.tscn")

func save_data():
	var save_file = File.new()
	save_file.open("res://save.txt", File.WRITE)
	save_file.store_string(str(charge_max) + "\r\n")
	save_file.store_string(str(coins) + "\r\n")
	save_file.store_string(str(bar_lvl))
	save_file.close()

func load_data():
	var save_file = File.new()
	save_file.open("res://save.txt", File.READ)
	charge_max = int(save_file.get_line())
	coins = int(save_file.get_line())
	bar_lvl = int(save_file.get_line())
	print(bar_lvl)
	
func hit(damage):
	charge -= damage
	if charge < 0:
		charge = 0
	updateUi()