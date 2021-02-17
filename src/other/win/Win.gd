extends Control


func _process(delta):
	if Input.is_action_just_pressed("menu"):
		get_tree().change_scene("res://src/other/menu/Menu.tscn")
