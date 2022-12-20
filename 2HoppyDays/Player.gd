extends KinematicBody2D

var motion = Vector2(0, 0)
export var move_speed = 500
export var gravity = 200
const UP = Vector2(0, -1)
export var  jump_speed = 1000

func _physics_process(delta):
	apply_gravity()
	jump()
	animate()
	move()

func apply_gravity():
	if not is_on_floor():
		motion.y += gravity
	else:
		motion.y = 0

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -move_speed
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = move_speed
	else:
		motion.x = 0
	move_and_slide(motion, UP)

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= jump_speed

func animate():
	if motion.y < 0:
		$AnimatedSprite.play("Jump")
	elif motion.x < 0:
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.set_flip_h(true)
	elif motion.x > 0:
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.set_flip_h(false)
	else:
		$AnimatedSprite.play("Idle")
