extends KinematicBody2D

var motion = Vector2(0, 0)
export var move_speed = 500
export var gravity = 200
const UP = Vector2(0, -1)
export var jump_speed = 1000
export var lives = 3
const WORLD_LIMIT = 4000

signal animate

func _physics_process(delta):
	apply_gravity()
	animate()
	jump()
	move()
	move_and_slide(motion, UP)

func apply_gravity():
	if position.y > WORLD_LIMIT:
		end_game()
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = gravity
	else:
		motion.y += gravity

func move():
	if Input.is_action_pressed("left") and not Input.is_action_pressed("right"):
		motion.x = -move_speed
	elif Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		motion.x = move_speed
	else:
		motion.x = 0

func jump():
	if Input.is_action_pressed("jump") and is_on_floor():
		motion.y -= jump_speed
		play_sound("res://SFX/jump1.ogg")

func animate():
	emit_signal("animate", motion)

func end_game():
	get_tree().change_scene("res://UI/GameOver.tscn")

func hurt():
	position.y -= 1
	yield(get_tree(), "idle_frame")
	motion.y -= jump_speed
	play_sound("res://SFX/pain.ogg")
	lives -= 1
	if lives < 0:
		end_game()

func play_sound(sound_path):
	$AudioStreamPlayer.stream = load(sound_path)
	$AudioStreamPlayer.play()
