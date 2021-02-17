extends Area2D

var healthHealed = 30


func _on_HealthPack_body_entered(body):
	if body.name == "Player":
		body.health += healthHealed
		body.playPickUpSound = true
		queue_free()

