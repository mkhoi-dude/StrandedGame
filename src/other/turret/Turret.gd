extends KinematicBody2D

var mounted = false
var rotationChange = 2.5
var bulletSpeed = 150
var fireRate = 0.25
var canShoot = true

onready var player = get_parent()
onready var bullet = preload("res://src/other/bullet/Bullet.tscn")

func turret_setup():
	if (player in $InteractionRadius.get_overlapping_bodies()) and Input.is_action_just_pressed("interact_turret") and !mounted:
		player.canControl = false
		mounted = true
		player.get_node("Camera2D").global_position = self.global_position
	elif Input.is_action_just_pressed("interact_turret") and mounted:
		mounted = false
		player.canControl = true
		player.get_node("Camera2D").global_position = player.global_position
		
	if Input.is_action_just_pressed("place_turret") and (player in $InteractionRadius.get_overlapping_bodies()):
		mounted = false
		player.canControl = true
		player.haveTurret = false
		player.get_node("Camera2D").global_position = player.global_position
		queue_free()

func _physics_process(delta):
	turret_setup()
	
	if mounted:
		if Input.is_action_pressed("move_left"):
			self.rotation_degrees -= rotationChange
		elif Input.is_action_pressed("move_right"):
			self.rotation_degrees += rotationChange
			
		if Input.is_action_pressed("shoot_turret") and canShoot and player.turretAmmo > 0:
			$SFX.play()
			player.turretAmmo -= 1
			var b = bullet.instance()
			add_child(b)
			b.global_position = $BulletPoint.global_position
			b.apply_central_impulse(Vector2(bulletSpeed,0).rotated(rotation))
			canShoot = false
			yield(get_tree().create_timer(fireRate), "timeout")
			canShoot = true
