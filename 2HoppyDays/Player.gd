extends KinematicBody2D

var motion = Vector2(0, 0)
const SPEED = 500
const GRAVITY = 200
const UP = Vector2(0, -1)
export var  jump_speed = 1000

func _physics_process(delta):
	apply_gravity()
	jump()
	move()

func apply_gravity():
	if not is_on_floor():
		motion.y += GRAVITY
	else:
		motion.y = 0

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0
	move_and_slide(motion, UP)

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= jump_speed
