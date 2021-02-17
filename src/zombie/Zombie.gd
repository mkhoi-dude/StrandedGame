extends KinematicBody2D

var velocity = Vector2()
var health = 65
var speed = 14
var damage = 6
var sawPlayer = false
var canAttack = true
var chancePack = 30
var chanceMedkit = 40

onready var player = get_parent().get_node("Player")
onready var healthPack = preload("res://src/other/healthPack/HealthPack.tscn")
onready var ammo = preload("res://src/other/ammoPack/AmmoPack.tscn")

func _physics_process(delta):
	randomize()
	if player in $DetectionRange.get_overlapping_bodies():
		sawPlayer = true
	
	if player in $AttackRange.get_overlapping_bodies() and canAttack:
		player.health -= damage
		$AudioStreamPlayer2D.play()
		canAttack = false
		yield(get_tree().create_timer(1),"timeout")
		canAttack = true
	
	if sawPlayer:
		velocity = position.direction_to(player.global_position)
		move_and_slide(velocity * speed)
		
	
	if health <= 0:
		if int(rand_range(0,100)) <= chancePack:
			if int(rand_range(0,100)) <= chanceMedkit:
				var h = healthPack.instance()
				add_child(h)
				h.global_position = self.global_position
			else:
				var a = ammo.instance()
				add_child(a)
				a.global_position = self.global_position
		queue_free()
