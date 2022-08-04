extends StaticBody2D
class_name AnotherOneBrickInTheWall

func take_hit():
	pass
	
func get_dimensions() -> Vector2:
	var rect : RectangleShape2D = $CollisionShape2D.shape
	return rect.extents * 2 * scale
