extends StaticBody2D

var bodies = []

var rot_vel = PI * 1.5

var PRE_BULLET = preload("res://scenes/turret_01_bullet.tscn")

func _ready():

	pass

func _process(delta):
	if bodies.size():
		var angle = $cannon.get_angle_to(bodies[0].global_position)
		if abs(angle) > .1: # abs tira sinal
			$cannon.rotation += rot_vel * delta * sign(angle)
		#$cannon.look_at(bodies[0].global_position) #olha para o primeiro da lista


func _on_sensor_body_entered(body):
	bodies.append(body)


func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)


func _on_Timer_timeout():
	var bullet = PRE_BULLET.instance()
	bullet.global_position = global_position
	bullet.dir = Vector2(cos($cannon.rotation), sin($cannon.rotation))
	get_parent().add_child(bullet)
