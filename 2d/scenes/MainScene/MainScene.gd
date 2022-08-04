extends Node

export (PackedScene) var shell_scene
export (PackedScene) var shooting_effects_scene
export (PackedScene) var wall_scene
export (PackedScene) var explosion_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	$Tank.position = screen_size / 2
	
	$BotTank1.position = screen_size / 4
	
	set_wall()



func _on_Tank_tank_shoots(position, rotation, shell_speed, tank_speed):
	var shell : Shell = shell_scene.instance()
	shell.position = position
	shell.init(rotation, shell_speed)
	shell.scale = 0.5 * Vector2.ONE
	shell.connect("collided", $".", "_on_Shell_collided")
	add_child(shell)
	
	var shot : ShootingEffects = shooting_effects_scene.instance()
	shot.position = position
	shot.init(rotation, tank_speed)
	add_child(shot)
		
func _on_Shell_collided(collision_position):
	var explosion = explosion_scene.instance()
	explosion.position = collision_position
	explosion.scale = Vector2.ONE * 0.25
	explosion.init()
	add_child(explosion)
	

func set_wall():
	var wall_tile : AnotherOneBrickInTheWall = wall_scene.instance()
	# wall_tile.position = Vector2(150, 150)
	# add_child(wall_tile)
	var wall_line = $Map/Wall/PathFollow2D
	# var offset = 
	
