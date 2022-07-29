extends RigidBody2D


func _ready():
	$Timer.start($SmokeParticles.lifetime)
	

func _on_Timer_timeout():
	queue_free()
