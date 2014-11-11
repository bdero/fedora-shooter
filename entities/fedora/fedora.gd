
extends AnimatedSprite


const MAX_SPEED = 3
const ACCEL_SPEED = 20
const FRICTION = ACCEL_SPEED*0.5

var x_speed = 0
var anim = get_node("anim")

func _ready():
	set_process(true)
	set_process_input(true)

func _process(dt):
	var left = Input.is_action_pressed("strafe_left")
	var right = Input.is_action_pressed("strafe_right")

	# Acceleration
	if left and not right:
		x_speed = max(x_speed - ACCEL_SPEED*dt, -MAX_SPEED)
	if right and not left:
		x_speed = min(x_speed + ACCEL_SPEED*dt, MAX_SPEED)

	# Friction
	if left == right:
		x_speed = max(abs(x_speed) - FRICTION*dt, 0)*sign(x_speed)

	# Apply movement
	set_pos(get_pos() + Vector2(x_speed, 0))
	#self.move_local_x(x_speed*dt)

func _input(event):
	if event.is_action("shoot") and Input.is_action_pressed("shoot"):
		tip()

func tip():
	anim.play("tip")
