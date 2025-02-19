extends CharacterBody2D

class_name Player

@export var health : float = 5
@export var speed : float = 200.0

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
@onready var npc_finder : Area2D = $NPCFinder

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true

func _unhandled_input(_event: InputEvent):
	if Input.is_action_pressed("enter"):
		var npc = npc_finder.get_overlapping_areas()
		if npc.size() > 0:
			npc[0].action()
			return
		
		return

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	update_health()

func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)


func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true

	emit_signal("facing_direction_changed", !sprite.flip_h)
	


func _on_hurtbox_hurt(damage):
	health -= damage
	if health <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://UI/game_over.tscn")
		
		
		
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	
	if health >= 5:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_timer_timeout():
	if health < 5:
		health = health + 1
		if health > 5:
			health = 5
	if health == 0:
		health = 0
