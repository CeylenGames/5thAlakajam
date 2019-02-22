extends KinematicBody2D

# Movement
export (float) var Speed = 100
var velocity = Vector2()

export (PackedScene) var Combo_Indic
export (Vector2) var Combo_Indic_Pos

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
		
func BeginCombo():
	print(Combo_Indic)
	var combo = Combo_Indic.instance()
	add_child(combo)
	combo.position = Combo_Indic_Pos
	combo.begin(10)
