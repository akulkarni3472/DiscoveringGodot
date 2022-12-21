extends AnimatedSprite

func _on_Player_animate(motion):
	if motion.y < 0:
		play("Jump")
	elif motion.x < 0:
		play("Walk")
		set_flip_h(true)
	elif motion.x > 0:
		play("Walk")
		set_flip_h(false)
	else:
		play("Idle")
