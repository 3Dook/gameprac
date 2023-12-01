extends Camera2D

@export var tilemap: TileMap
# Called when the node enters the scene tree for the first time.
func _ready():
	var mapRect = tilemap.get_used_rect()
	var tileSize = tilemap.cell_quadrant_size
	var worldSizeInPixels = mapRect.size * tileSize
	print(tilemap.cell_quadrant_size)
	limit_right = worldSizeInPixels.x 
	limit_bottom = worldSizeInPixels.y
	#set_limit(SIDE_RIGHT, worldSizeInPixels.x)
	#$set_limit(SIDE_BOTTOM, worldSizeInPixels.y)
	#limit_right = 2040
	#limit_bottom = 1210
	print(worldSizeInPixels)
	print(limit_right)
	print(limit_bottom)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
