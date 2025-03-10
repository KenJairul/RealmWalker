extends Area2D

@export var damage = 3

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableHitboxTimer 

func tempdisable():
	collision.call_deferred("set", "disabled", true)
	disableTimer.start()
	
func _on_disable_hitbox_timer_timeout():
	collision.call_deferred("set", "disabled", false)
