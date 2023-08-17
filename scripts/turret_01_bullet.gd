extends Area2D

const MAX_DIST = 300

var dir = Vector2() setget set_dir
var vel = 400
onready var init_pos = global_position


func _ready():
	pass

func _physics_process(delta):
	if global_position.distance_to(init_pos) >= MAX_DIST:
			queue_free()
	
	translate(dir * vel * delta)
	
func set_dir(val):
	dir = val
	rotation = dir.angle()
