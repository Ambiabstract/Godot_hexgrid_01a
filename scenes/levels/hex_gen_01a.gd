@tool
extends Node3D

# Параметры гексагональной сетки
var _grid_width: int = 10
var _grid_height: int = 10
var _hex_diameter: float = 1.0

@export var grid_width: int:
	get: return _grid_width
	set(value):
		_grid_width = clamp(value, 1, 128)
		generate_hex_grid()

@export var grid_height: int:
	get: return _grid_height
	set(value):
		_grid_height = clamp(value, 1, 128)
		generate_hex_grid()

@export var hex_diameter: float:
	get: return _hex_diameter
	set(value):
		_hex_diameter = clamp(value, 0.1, 10.0)
		generate_hex_grid()

"""
@export var regenerate_grid: bool:
	set(value):
		regenerate_grid = value
		if value:
			generate_hex_grid()
	get:
		return regenerate_grid
"""

# Вычисление полезных значений
var hex_radius: float
var hex_width: float
var hex_height: float

# Список для хранения гексагонов
var hex_tiles: Array = []

func _ready():
	generate_hex_grid()

func generate_hex_grid():
	print("generate_hex_grid")
	clear_grid()
	hex_radius = hex_diameter / 2.0
	hex_width = hex_diameter
	hex_height = sqrt(3) * hex_radius
	for y in range(grid_height):
		for x in range(grid_width):
			var hex_position = calculate_hex_position(x, y)
			create_hex_tile(hex_position)

func calculate_hex_position(x: int, y: int) -> Vector3:
	# Смещение для чётных/нечётных рядов
	var x_offset = hex_width * 0.75 * x
	var y_offset = hex_height * (y + 0.5 * (x % 2))
	return Vector3(x_offset, 0, y_offset)

func create_hex_tile(position: Vector3):
	var hex_tile = CSGCylinder3D.new()
	hex_tile.radius = hex_radius
	hex_tile.height = 0.2
	hex_tile.sides = 6
	hex_tile.rotation_degrees = Vector3(0, 0, 0)
	hex_tile.position = position
	add_child(hex_tile)
	hex_tiles.append(hex_tile)

func clear_grid():
	for hex_tile in hex_tiles:
		hex_tile.queue_free()
	hex_tiles.clear()
