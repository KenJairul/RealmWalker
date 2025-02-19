extends Area2D

const Balloon = preload("res://dialogue/balloon.tscn")

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

@export var dialouge_resource : DialogueResource
@export var dialouge_start : String = "start"

func _ready():
	animated_sprite.play("default")

func action() -> void:
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	DialogueManager.show_example_dialogue_balloon(dialouge_resource, dialouge_start)
