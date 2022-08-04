extends KinematicBody2D
class_name Shell

signal collided(position)

var velocity = Vector2.ZERO

func init(tank_rotation: float, shell_speed: float):
	var direction = Vector2.UP.rotated(tank_rotation)
	velocity = direction * shell_speed
	rotation = tank_rotation

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.collider
		collider.take_hit()
		emit_signal("collided", collision.position)
		queue_free()
		# print_debug('collided with %d' % collided_id)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func take_hit():
	emit_signal("collided", position)
	queue_free()
