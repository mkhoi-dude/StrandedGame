extends Area2D




func _on_Fuel_body_entered(body):
	if body.name == "Player":
		body.fuel += 1
		body.playPickUpSound = true
		queue_free()

