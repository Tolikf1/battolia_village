extends KinematicBody2D

export (float) var speed
export (float) var rotation_speed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	movement(delta)


func movement(delta):
	var input_speed = 0
	var input_rotation = 0
	
	if Input.is_action_pressed("move_forward"):
		input_speed += 1
	if Input.is_action_pressed("move_back"):
		input_speed -= 1
	if Input.is_action_pressed("rotate_CCW"):
		input_rotation -= 1
	if Input.is_action_pressed("rotate_CW"):
		input_rotation += 1
		
	rotation += input_rotation * rotation_speed * delta
	var direction = Vector2.UP.rotated(rotation)
	var delta_position = direction * input_speed * speed * delta
	position += delta_position
