extends RigidBody2D

class_name ShootingEffects

func init(tank_rotation: float, tank_speed: float):
	rotation = tank_rotation
	linear_velocity = Vector2.UP.rotated(rotation) * tank_speed

func _ready():
	$Timer.start($SmokeParticles.lifetime)

func _on_Timer_timeout():
	queue_free()
