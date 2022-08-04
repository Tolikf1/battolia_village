extends Node2D

func init():
	$AnimatedSprite.frame = 0

func _on_AnimatedSprite_animation_finished():
	queue_free()
