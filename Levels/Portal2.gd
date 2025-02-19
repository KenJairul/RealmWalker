extends Area2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
var entered = false

func _ready():
	animated_sprite.play("portal")

func _on_body_entered(body : CharacterBody2D):
	entered = true

func _on_body_exited(body):
	entered = false

func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("enter"):
			get_tree().change_scene_to_file("res://Levels/level_3.tscn")
