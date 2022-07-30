extends KinematicBody2D

class_name Shell

var velocity = Vector2.ZERO

func init(direction: Vector2, shell_speed: float):
	velocity = direction * shell_speed
	rotation = -direction.angle_to(Vector2.UP)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	# if collision:
		# var collided_id = collision.collider_id
		# print_debug('collided with %d' % collided_id)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
