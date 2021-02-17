extends Node2D

func _process(delta):
	if $Car.playerEntered and $Player.fuel >= $Fuel.get_child_count():
		$Control/Label4.visible = true
		$Control/Label2.visible = false
		$Control/Label3.visible = false
		yield(get_tree().create_timer(2),"timeout")
		get_tree().change_scene("res://src/mainGame/MainGame.tscn")
