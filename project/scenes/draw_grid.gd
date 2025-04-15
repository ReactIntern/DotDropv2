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

# This function centers the grid once at the start of the scene
func _ready():
	center_on_camera()

# Center the grid on the camera
func center_on_camera():
	var camera_center = main_camera.get_screen_center_position()
	var grid_pixel_size = Vector2(columns * grid_size, rows * grid_size)

	# Set this node’s position so the grid is centered on the camera
	position = camera_center - (grid_pixel_size / 2)

# Move objects upwards by adjusting the object_offset
func _process(delta):
	object_offset.y -= 2 * delta  # Adjust the value for speed (pixels per second)

	# Optional: Move objects in the scene based on object_offset
	# For example, if you have a node called "object":
	# var object = get_node("Object")
	# object.position += object_offset  # Apply movement to object

	# You can also apply this offset to other objects, based on your logic
	# For example, looping through all objects in a group or by name:

	# Apply upward movement to all objects that need to move upwards
	for obj in get_children():
		if obj is Node2D:  # Make sure it’s a movable object
			obj.position += Vector2(0, -2 * delta)  # Move upwards

	# Redraw the grid
	queue_redraw()

# Draw the grid and highlight the cell
func _draw():
	var width = columns * grid_size
	var height = rows * grid_size

	# Draw grid
	for x in range(columns + 1):
		draw_line(Vector2(x * grid_size, 0), Vector2(x * grid_size, height), grid_color, grid_width)

	for y in range(rows + 1):
		draw_line(Vector2(0, y * grid_size), Vector2(width, y * grid_size), grid_color, grid_width)

	# Draw highlight at (2, 8)
	var highlight_pos = Vector2(2, 8) * grid_size
	draw_rect(Rect2(highlight_pos, Vector2(grid_size, grid_size)), highlight_color)

	# Optional: Draw debug dot
	draw_circle(highlight_pos + Vector2(grid_size / 2, grid_size / 2), 4, Color.RED)
