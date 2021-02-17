extends Area2D

var ammoAdded = 20


func _on_AmmoPack_body_entered(body):
	if body.name == "Player":
		body.turretAmmo += ammoAdded
		body.playPickUpSound = true
		queue_free()

