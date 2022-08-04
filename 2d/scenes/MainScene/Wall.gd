extends Path2D

export (PackedScene) var wall_tile_scene


# Called when the node enters the scene tree for the first time.
func _ready():
	build_wall()


func build_wall():
	var tile : AnotherOneBrickInTheWall = wall_tile_scene.instance()
	var wall_length = curve.get_baked_length()
	var tile_size = tile.get_dimensions()
	
	for offset in range(0, wall_length, tile_size.x):
		tile = wall_tile_scene.instance()
		$PathFollow2D.offset = offset
		tile.position = $PathFollow2D.position
		add_child(tile)
