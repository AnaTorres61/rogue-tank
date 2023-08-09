extends Area2D
# class member variables go here
var dir = Vector2(0,-1) setget set_dir
var vel = 300

func _ready():
	
	pass

func _process(delta):
	translate(dir * vel * delta)

# delete on screen exit
func _on_notifier_screen_exited():
	queue_free()

func set_dir(val):
	dir = val
	rotation = dir.angle()