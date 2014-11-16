
extends Sprite


var spin_speed = (randf()*2 - 1)*25
var speed = Vector2(0, -500)


func _ready():
	set_frame(randi()%(get_hframes()*get_vframes()))
	set_process(true)

func _process(dt):
	set_rot(get_rot() + spin_speed*dt)
	set_pos(get_pos() + speed*dt)

	if not get_viewport_rect().has_point(get_pos()):
		get_parent().remove_and_delete_child(self)
