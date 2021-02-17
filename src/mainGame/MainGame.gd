extends Node2D

onready var zombie = preload("res://src/zombie/Zombie.tscn")
onready var health = preload("res://src/other/healthPack/HealthPack.tscn")
onready var ammo = preload("res://src/other/ammoPack/AmmoPack.tscn")

var chancePack = 75
var chanceMedkit = 45

func _ready():
	randomize()
	for i in $ZombieSpawns.get_children():
		var z = zombie.instance()
		add_child(z)
		z.global_position = i.global_position
	
	for i in $PackSpawns.get_children():
		if int(rand_range(0,100)) <= chancePack:
			if int(rand_range(0,100)) <= chanceMedkit:
				var h = health.instance()
				add_child(h)
				h.global_position = i.global_position
			else:
				var a = ammo.instance()
				add_child(a)
				a.global_position = i.global_position
				
func _process(delta):
	if $Player.health <= 0:
		get_tree().change_scene("res://src/other/deathScene/Death.tscn")
		
	if $Car.playerEntered and $Player.fuel >= $Fuel.get_child_count():
		get_tree().change_scene("res://src/other/win/Win.tscn")
