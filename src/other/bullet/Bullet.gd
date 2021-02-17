extends RigidBody2D

var damage = 20

func _ready():
	set_as_toplevel(true)

func _on_Bullet_body_entered(body):
	if body.is_in_group("enemy"):
		body.sawPlayer = true
		body.health -= damage
	queue_free()
