extends Area2D

var max_dist = 300

var dir = Vector2() setget set_dir
var vel = 400
onready var init_pos = global_position


func _ready():
	pass

func _physics_process(delta):
	if global_position.distance_to(init_pos) >= max_dist:
			queue_free()
	
	translate(dir * vel * delta)
	
func set_dir(val):
	dir = val
	rotation = dir.angle()
