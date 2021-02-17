extends KinematicBody2D

export var speed = 20
export var health = 100

var velocity = Vector2.ZERO
var canControl = true
var haveTurret = false
var turretAmmo = 32
var fuel = 0
var playPickUpSound = false

onready var numOfFuel = get_parent().get_node("Fuel").get_child_count()
onready var turret = preload("res://src/other/turret/Turret.tscn")

func play_sound(sound):
	$SFX.stream = load(sound)
	$SFX.play()

func input():
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	elif Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	elif Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if canControl:
		input()
		velocity = move_and_slide(velocity)
		
	if health > 100:
		health = 100
	elif health <= 0:
		health = 0
		
	if playPickUpSound:
		play_sound("res://assets/sounds/sfx/blip12.wav")
		playPickUpSound = false
		
	$Camera2D/Control/HP.text = "HP:" + str(health)
	$Camera2D/Control/BUL.text = "BUL:" + str(turretAmmo)
	$Camera2D/Control/fuel.text = str(fuel) + "/" + str(numOfFuel)
		
	if Input.is_action_just_pressed("place_turret") and haveTurret == false:
		play_sound("res://assets/sounds/sfx/blip10.wav")
		haveTurret = true
		var t = turret.instance()
		add_child(t)
		t.set_as_toplevel(true)
		t.global_position = Vector2(self.global_position.x + 4,self.global_position.y)
		
