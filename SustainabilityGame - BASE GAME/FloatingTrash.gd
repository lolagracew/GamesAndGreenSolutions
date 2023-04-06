extends KinematicBody2D


var motion = Vector2()
var state= 0

func _physics_process(delta):
	state = floor(rand_range(0,3))

	if state == 0:
		motion.x = 0
	elif state == 1:
		motion.x = 100
	elif state == 2:
		motion.x = -100
	
	move_and_slide(motion, Vector2(0,-1))
		
func timeout():
	state = floor(rand_range(0,3))
