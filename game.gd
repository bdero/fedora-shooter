
extends Node2D


const DEFAULT_FIELD_SIZE = Vector2(800, 600)

var camera


func _ready():
	camera = get_node("camera")
	get_viewport().connect("size_changed", self, "_on_viewport_size_changed")

func _on_viewport_size_changed():
	# Scale based on width
	var ratio = get_viewport_rect().size/DEFAULT_FIELD_SIZE
	var scale = ratio.x
	set_scale(Vector2(1, 1)*scale)

	# Set camera to full width at bottom of playing field
	var offset_x = DEFAULT_FIELD_SIZE.x*scale/2
	var offset_y = DEFAULT_FIELD_SIZE.y*scale - get_viewport_rect().size.y/2
	camera.set_offset(Vector2(offset_x, offset_y))
