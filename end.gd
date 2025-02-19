extends Control

func _ready():
	pass
	
func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://UI/menu.tscn")
