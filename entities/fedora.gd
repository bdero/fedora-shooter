
extends AnimatedSprite


const MOVE_SPEED = 600


func _ready():
	set_process(true)

func _process(dt):
	if Input.is_action_pressed("strafe_left"):
		self.move_local_x(-MOVE_SPEED*dt)
	if Input.is_action_pressed("strafe_right"):
		self.move_local_x(MOVE_SPEED*dt)
