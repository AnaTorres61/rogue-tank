extends ColorRect

onready var init_ret_size = rect_size
var scale = 1 setget set_scale

func _ready():
	pass

func _draw():
	draw_rect(Rect2(Vector2(), init_ret_size), Color(0, .6, 0), false)

func set_scale(val):
	scale = val
	rect_size.x = init_ret_size.x * scale
