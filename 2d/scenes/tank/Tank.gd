extends KinematicBody2D
class_name Tank

class Controls:
	var throttle : float
	var rotation : float
	var shoot : bool
	
	func _init(throttle_: float, rotation_: float, shoot_: bool):
		throttle = throttle_
		rotation = rotation_
		shoot = shoot_

export (float) var speed
export (float) var rotation_speed
export (bool) var is_bot

export (float) var shell_speed

signal tank_shoots(position, rotation, shell_speed, tank_speed)
signal tank_dies(position, rotation)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	var controls : Controls = null
	if is_bot == false:
		controls = human_get_controls()
	elif is_bot == true:
		controls = bot_get_controls()
	
	movement(delta, controls)
	if controls.shoot == true:
		shoot(controls.throttle * speed)


func movement(delta, controls : Controls):
	rotation += controls.rotation * rotation_speed * delta
	var direction = Vector2.UP.rotated(rotation)
	var velocity = direction * controls.throttle * speed
	move_and_slide(velocity)
	
	animate_tracks(controls.rotation, controls.throttle)

# speed, rotation є {0, 1, -1}
func animate_tracks(speed: float, rotation: float):
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

func shoot(speed: float):
	var nozzle_position_in_parent = position + $NozzlePosition.position.rotated(rotation)
	emit_signal("tank_shoots", nozzle_position_in_parent, rotation, shell_speed, speed)
		
func human_get_controls() -> Controls:
	var input_speed = 0
	var input_rotation = 0
	var is_shot = false
	
	if Input.is_action_pressed("move_forward"):
		input_speed += 1
	if Input.is_action_pressed("move_back"):
		input_speed -= 1
	if Input.is_action_pressed("rotate_CCW"):
		input_rotation -= 1
	if Input.is_action_pressed("rotate_CW"):
		input_rotation += 1
		
	if Input.is_action_just_pressed("fire_weapon"):
		is_shot = true
	
	return Controls.new(input_speed, input_rotation, is_shot)
	
func bot_get_controls() -> Controls:
	return Controls.new(0,0,false)
	
func take_hit():
	emit_signal("tank_dies", position, rotation)
	queue_free()
