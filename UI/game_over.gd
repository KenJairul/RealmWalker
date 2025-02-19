extends Control


func _ready():
	pass # Replace with function body.


func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://UI/menu.tscn")
