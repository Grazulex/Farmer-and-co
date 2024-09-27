extends CharacterBody2D

enum player_states {WALK, JUMP, SWORD}
var current_states = player_states.WALK

@onready var anim_tree = $anim_tree
@onready var anim_state = anim_tree.get('parameters/playback')

@export var speed_walk:int = 50
@export var speed_run:int = 80
var input_movement = Vector2()

func _ready():
	$SwordArea/CollisionShape2D.disabled = true

func _physics_process(delta):
	match current_states:
		player_states.WALK:
			move()
		player_states.SWORD:
			sword()
	
func move():
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_tree.set("parameters/Jump/blend_position", input_movement)
		$Walk.show()
		$Idle.hide()
		$Sword.hide()
		anim_state.travel("Walk")
		
		velocity = input_movement * speed_walk
		
	if input_movement == Vector2.ZERO:
		$Idle.show()
		$Sword.hide()
		$Walk.hide()
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
		
	if Input.is_action_just_pressed("ui_sword"):
		current_states = player_states.SWORD
		
	move_and_slide()
	
func sword():
	$Sword.show()
	$Walk.hide()
	$Idle.hide()
	anim_state.travel("Sword")
	
func on_states_reset():
	current_states = player_states.WALK
