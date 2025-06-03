extends Node2D

const BLACK:Vector2i = Vector2i(1,0)
const WHITE:Vector2i = Vector2i(2,0)

const TILE_SIZE:int = 32

var lightMap:TileMapLayer
var map:TileMapLayer

@export var width:int = 64
@export var height:int = 64

func _ready() -> void:
	lightMap = $SubViewport/TileMapLayer
	map = $TileMapLayer
	
	for y:int in height:
		for x:int in width:
			if map.get_cell_atlas_coords( Vector2i(x,y) )!=Vector2i(-1,-1):
				lightOFF(x,y)
			else:
				lightON(x,y)
			

func _process(delta: float) -> void:
	var pos = get_global_mouse_position()
	
	pos = Vector2i( pos.x/TILE_SIZE, pos.y/TILE_SIZE )
	pos = Vector2i( pos.x*TILE_SIZE+TILE_SIZE/2,pos.y*TILE_SIZE+TILE_SIZE/2 )
	
	$SubViewport/PointLight2D.position = pos
	$Sprite2D.position = pos
	$SubViewport/Camera2D.position = pos
	pass

func lightON( x:int, y:int ):
	lightMap.set_cell( Vector2i(x,y),0,WHITE )

func lightOFF( x:int, y:int ):
	lightMap.set_cell( Vector2i(x,y),0,BLACK )
