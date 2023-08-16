extends StaticBody2D

var bodies = []

func _ready():

	pass

func _process(delta):
	if bodies.size():
		$cannon.look_at(bodies[0].global_position) #olha para o primeiro da lista


func _on_sensor_body_entered(body):
	bodies.append(body)


func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
