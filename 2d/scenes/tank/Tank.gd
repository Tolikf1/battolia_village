extends KinematicBody2D

export (float) var speed
export (float) var rotation_speed

export (PackedScene) var shell_scene
export (float) var shell_speed

export (PackedScene) var shooting_effects_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
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
	var velocity = direction * input_speed * speed
	move_and_slide(velocity)
	
	animate_tracks(input_speed, input_rotation)
	shoot(input_speed * speed)

# speed, rotation є {0, 1, -1}
func animate_tracks(speed, rotation):
	if speed:
		$Spites/Tracks/L.playing = true
		$Spites/Tracks/R.playing = true
	elif rotation == 1:
		$Spites/Tracks/L.playing = true
		$Spites/Tracks/R.playing = false
	elif rotation == -1:
		$Spites/Tracks/L.playing = false
		$Spites/Tracks/R.playing = true
	else:
		$Spites/Tracks/L.playing = false
		$Spites/Tracks/R.playing = false

func shoot(speed):
	if Input.is_action_just_pressed("fire_weapon"):
		var shell = shell_scene.instance()
		shell.position = $NozzlePosition.position
		shell.init(Vector2.UP.rotated(rotation), shell_speed)
		add_child(shell)
		
		var shot = shooting_effects_scene.instance()
		shot.position = $NozzlePosition.position
		shot.linear_velocity = Vector2.UP.rotated(rotation) * speed
		add_child(shot)
