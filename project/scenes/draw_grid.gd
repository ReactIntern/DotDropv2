extends Node2D

@export var grid_size := 16  # Try 32 for smaller cells
@export var grid_color := Color(1, 1, 1, 0.2)
@export var grid_width := 1.0
@export var columns := 9
@export var rows := 13
@onready var main_camera: Camera2D = $"../../MainCamera"
@export var highlight_cell := Vector2i(1, 1)
@export var highlight_color := Color(1, 0, 0, 0.3)  # Semi-transparent red
# Position offset for objects (will move upward)
var object_offset := Vector2(0, 0)
var grid_origin := Vector2.ZERO
# This function centers the grid once at the start of the scene
func _ready():
	
	center_on_camera()
	queue_redraw()
# Center the grid on the camera
func center_on_camera():
	if main_camera == null:
		return
	var camera_center = main_camera.get_screen_center_position()
	var grid_pixel_size = Vector2(columns * grid_size, rows * grid_size)
	grid_origin = camera_center - (grid_pixel_size / 2)
# Draw the grid and highlight the cell
func _draw():
	var width = columns * grid_size
	var height = rows * grid_size

	# Draw grid lines offset by grid_origin
	for x in range(columns + 1):
		var x_pos = x * grid_size + grid_origin.x
		draw_line(Vector2(x_pos, grid_origin.y), Vector2(x_pos, grid_origin.y + height), grid_color, grid_width)

	for y in range(rows + 1):
		var y_pos = y * grid_size + grid_origin.y
		draw_line(Vector2(grid_origin.x, y_pos), Vector2(grid_origin.x + width, y_pos), grid_color, grid_width)

	# Highlight cell (e.g., (2, 8))
	var highlight_pos = Vector2(2, 8) * grid_size + grid_origin
	draw_rect(Rect2(highlight_pos, Vector2(grid_size, grid_size)), highlight_color)

	# Optional debug dot in the center of the highlighted cell
	draw_circle(highlight_pos + Vector2(grid_size / 2, grid_size / 2), 4, Color.RED)
