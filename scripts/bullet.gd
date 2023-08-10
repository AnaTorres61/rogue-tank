extends Area2D
# class member variables go here
const MAX_DIST = 250

var dir = Vector2(0,-1) setget set_dir
var vel = 300
onready var init_pos = global_position

func _ready():
	pass

func _process(delta):
	if global_position.distance_to(init_pos) >= MAX_DIST:
		queue_free()
	
	translate(dir * vel * delta)

# delete on screen exit
func _on_notifier_screen_exited():
	queue_free()

func set_dir(val):
	dir = val
	rotation = dir.angle()