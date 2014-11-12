
extends AnimatedSprite


var anim
var sound
var shoot_timer

const MAX_SPEED = 3
const ACCEL_SPEED = 20
const FRICTION = ACCEL_SPEED*0.5

var x_speed = 0
var previous_shooting = false


func _ready():
	anim = get_node("anim")
	sound = get_node("sample_player")
	shoot_timer = get_node("shoot_timer")

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

	var new_pos = get_pos() + Vector2(x_speed, 0)

	# Boundaries
	if new_pos.x < 0 or new_pos.x > 800:
		x_speed = 0
		new_pos.x = max(min(new_pos.x, 800), 0)

	# Apply movement
	set_pos(new_pos)

func _input(event):
	if event.is_action("shoot"):
		var shooting = Input.is_action_pressed("shoot")
		if shooting and not previous_shooting:
			do_tip()
			shoot_timer.start()
		elif not shooting and previous_shooting:
			shoot_timer.stop()

		previous_shooting = shooting

func _on_shoot_timer_timeout():
	do_tip()

func do_tip():
	tip()

func tip():
	anim.play("tip")
	sound.play("tip")
