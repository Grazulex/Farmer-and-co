extends CharacterBody2D

@onready var anim_tree = $anim_tree
@onready var anim_state = anim_tree.get('parameters/playback')

@export var speed_walk:int = 50
@export var speed_run:int = 80
var input_movement = Vector2()

func _physics_process(delta):
	move()
	
func move():
	input_movement = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if input_movement != Vector2.ZERO:
		anim_tree.set("parameters/Idle/blend_position", input_movement)
		anim_tree.set("parameters/Walk/blend_position", input_movement)
		anim_tree.set("parameters/Sword/blend_position", input_movement)
		anim_tree.set("parameters/Run/blend_position", input_movement)
		anim_tree.set("parameters/Jump/blend_position", input_movement)
		anim_tree.set("parameters/Axe/blend_position", input_movement)
		anim_tree.set("parameters/Hoe/blend_position", input_movement)
		anim_state.travel("Walk")
		
		velocity = input_movement * speed_walk
		
	if input_movement == Vector2.ZERO:
		anim_state.travel("Idle")
		velocity = Vector2.ZERO
		
	move_and_slide()
