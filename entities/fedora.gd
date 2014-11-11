
extends AnimatedSprite


const MAX_SPEED = 600
const ACCEL_SPEED = 50
const FRICTION = ACCEL_SPEED*0.8

var x_speed = 0


func _ready():
	set_process(true)

func _process(dt):
	var left = Input.is_action_pressed("strafe_left")
	var right = Input.is_action_pressed("strafe_right")

	# Acceleration
	if left and not right:
		x_speed = max(x_speed - ACCEL_SPEED*ACCEL_SPEED*dt, -MAX_SPEED)
	if right and not left:
		x_speed = min(x_speed + ACCEL_SPEED*ACCEL_SPEED*dt, MAX_SPEED)

	# Friction
	if left == right:
		x_speed = max(abs(x_speed) - FRICTION*FRICTION*dt, 0)*sign(x_speed)

	# Apply movement
	self.move_local_x(x_speed*dt)
