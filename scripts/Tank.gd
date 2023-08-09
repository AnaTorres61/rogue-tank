tool
extends KinematicBody2D

onready var BULLET_TANK_GROUP = "bullet-" + str(self)

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var speed = 200
var pre_bullet = preload("res://scenes/bullet.tscn")

export(int, "bigRed", "blue", "dark", "darkLarge", "green", "huge", "red", "sand") var bodie = 2 setget set_bodie
export(int, "dark1", "dark2", "dark3", "green1", "green2", "green3", "red1", "red2", "red3", "sand1", "sand2", "sand3") var barrel = 0 setget set_barrel

var bodies = [
	"res://sprites/tankBody_bigRed.png",
	"res://sprites/tankBody_blue.png",
	"res://sprites/tankBody_dark.png",
	"res://sprites/tankBody_darkLarge.png",
	"res://sprites/tankBody_green.png",
	"res://sprites/tankBody_huge.png",
	"res://sprites/tankBody_red.png",
	"res://sprites/tankBody_sand.png",
]

var barrels = [
	"res://sprites/tankDark_barrel1.png",
	"res://sprites/tankDark_barrel2.png",
	"res://sprites/tankDark_barrel3.png",
	"res://sprites/tankGreen_barrel1.png",
	"res://sprites/tankGreen_barrel2.png",
	"res://sprites/tankGreen_barrel3.png",
	"res://sprites/tankRed_barrel1.png",
	"res://sprites/tankRed_barrel2.png",
	"res://sprites/tankRed_barrel3.png",
	"res://sprites/tankSand_barrel1.png",
	"res://sprites/tankSand_barrel2.png",
	"res://sprites/tankSand_barrel3.png",
]

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass
	
func _draw(): # Quando o objeto precisa ser redesenhado
	$sprite.texture = load(bodies[bodie])
	$barrel/sprite.texture = load(barrels[barrel])

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if Engine.editor_hint:
		return
	
	var dir_x = 0
	var dir_y = 0
	
#	tank vertical move
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1
#	tank horizontal move
	if Input.is_action_pressed("ui_up"):
		dir_y -= 1
	if Input.is_action_pressed("ui_down"):
		dir_y += 1
#	shoot move
	if Input.is_action_just_pressed("ui_shoot"):
#		if there are up to three bullets in the group
		if get_tree().get_nodes_in_group(BULLET_TANK_GROUP).size() < 6:
			var bullet = pre_bullet.instance()
			# put the bullet on the tip cannon
			bullet.global_position = $barrel/muzzle.global_position
			bullet.dir = Vector2(cos(rotation), sin(rotation)).normalized()
			bullet.add_to_group(BULLET_TANK_GROUP)
			# put the bullet in the scene
			get_parent().add_child(bullet) # $"../".add_child(bullet)
			$barrel/anim.play("fire")
			
	look_at(get_global_mouse_position())
	
	move_and_slide(Vector2(dir_x,dir_y) * speed)
	
	
func set_bodie(val):
	bodie = val
	if Engine.editor_hint:
		update()
		
func set_barrel(val):
	barrel = val
	if Engine.editor_hint:
		update()
