extends StaticBody2D

var playerEntered = false

func _on_FuelRadius_body_entered(body):
	if body.name == "Player":
		playerEntered = true


func _on_FuelRadius_body_exited(body):
	if body.name == "Player":
		playerEntered = false
