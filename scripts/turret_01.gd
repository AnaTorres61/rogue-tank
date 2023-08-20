tool
extends StaticBody2D

var bodies = []
var rot_vel = PI/2
export(float, 0, 360) var start_rot = 0.0 setget set_start_rot

export(float, 100, 1000) var sensor_radius = 100 setget set_sensor_radius

const PRE_BULLET = preload("res://scenes/turret_01_bullet.tscn")

export var life = 100

func _ready():
	pass

func _process(delta):
	if bodies.size():
		var angle = $cannon.get_angle_to(bodies[0].global_position)
		if abs(angle) > .01: # abs tira sinal
			$cannon.rotation += rot_vel * delta * sign(angle)
	if $cannon/sight.is_colliding():
		if $cannon/sight.get_collider() != bodies[0]:
			var oldBody = bodies[0]
			var newBodyIndex =  bodies.find($cannon/sight.get_collider())
			bodies[0] = $cannon/sight.get_collider()
			bodies[newBodyIndex] = oldBody
			
func _draw():
	$cannon.rotation = deg2rad(start_rot)
	var new_shape = CircleShape2D.new()
	new_shape.radius = sensor_radius
	$sensor/shape.shape = new_shape
	$cannon/sight.cast_to.x = sensor_radius


func _on_sensor_body_entered(body):
	if !bodies.size():
		$shoot_timer.start()
	bodies.append(body)
	$cannon/sight.enabled = true


func _on_sensor_body_exited(body):
	var index = bodies.find(body)
	if index >= 0:
		bodies.remove(index)
	if !bodies.size():
		$cannon/sight.enabled = false
		$shoot_timer.stop()


func _on_shoot_timer_timeout():
	if $cannon/sight.is_colliding():
		var bullet = PRE_BULLET.instance()
		bullet.global_position = global_position
		bullet.dir = Vector2(cos($cannon.rotation), sin($cannon.rotation))
		bullet.max_dist = sensor_radius
		get_parent().add_child(bullet)


func set_start_rot(val):
	start_rot = val
	if Engine.editor_hint:
		update()
		
func set_sensor_radius(val):
	sensor_radius = val
	if Engine.editor_hint:
		update()

func _on_weak_spot_damage(damage, node):
	life -= damage
	if life <= 0:
		set_process(false)
		$cannon.queue_free()
		$sensor.disconnect("body_exited",self,"on_sensor_body_exited")
		$sensor.queue_free()
		$shoot_timer.queue_free()
		$weak_spot.queue_free()
