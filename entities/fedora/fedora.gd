
extends AnimatedSprite


var anim
var sound
var shoot_timer
var bullet = load("res://entities/bullet/bullet.xscn")

const MAX_SPEED = 600
const ACCEL_SPEED = 15
const FRICTION = ACCEL_SPEED*0.6

var x_speed = 0
var previous_shooting = false


func _ready():
	anim = get_node("anim")
	sound = get_node("sample_player")
	shoot_timer = get_node("shoot_timer")

	set_as_toplevel(true)

	set_process(true)
	set_process_input(true)

func _process(dt):
	var left = Input.is_action_pressed("strafe_left")
	var right = Input.is_action_pressed("strafe_right")

	# Acceleration
	if left and not right:
		x_speed = max(x_speed - ACCEL_SPEED, -MAX_SPEED)
	if right and not left:
		x_speed = min(x_speed + ACCEL_SPEED, MAX_SPEED)

	# Friction
	if left == right:
		x_speed = max(abs(x_speed) - FRICTION, 0)*sign(x_speed)

	var new_pos = get_pos() + Vector2(x_speed, 0)*dt

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

	var new_bullet = bullet.instance()
	new_bullet.set_pos(get_pos() + Vector2(0, -10))
	new_bullet.speed.x = x_speed

	get_parent().add_child(new_bullet)
