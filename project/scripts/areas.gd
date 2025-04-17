extends Node
var screen_size: Vector2
#var camera_width = 560
#var camera_height = 800
var platform = preload('res://scenes/platform.tscn')
var coin = preload("res://scenes/coin.tscn")
var EnemyPlat = preload("res://scenes/EnemyPlat.tscn")
var spawn_interval = 1.0
var spawn_timer: Timer
var spawned_positions = []
@onready var score_label: Label = $ScoreLabel
@onready var main_camera: Camera2D = $"../MainCamera"
@onready var delay_timer: Timer = $DelayTimer

@export var grid_size := 16  # Try 32 for smaller cells
@export var grid_color := Color(1, 1, 1, 0.2)
@export var grid_width := 1.0
@export var columns := 9
@export var rows := 13
@export var highlight_cell := Vector2i(1, 1)
@export var highlight_color := Color(1, 0, 0, 0.3)  # Semi-transparent red
# Position offset for objects (will move upward)
var object_offset := Vector2(0, 0)
var platforms = []
var CanScroll = false
var items = [
	{"obj": EnemyPlat, "chance": 0.5, "size": Vector2(4, 4)},
	#{"obj": platform, "chance": 0.7, "size": Vector2(4, 4)},
	#{"obj": coin, "chance": 0.3, "size": Vector2(4, 4)}
]
var grid_origin := Vector2i.ZERO
var score = 0

func _ready():
	randomize()
	center_on_camera()

	for y in rows:
		for x in columns:
			var grid_coords = Vector2i(x, y)
			var item = pick_weighted_item()
			var obj_scene = item["obj"]
			var size = item["size"]

			var new_obj = obj_scene.instantiate()
			new_obj.position = get_aligned_grid_position(grid_coords, size)
			add_child(new_obj)
	
func _on_delay_timer_timeout(new_obj):
	print("5 seconds passed. Do something now.")
	add_child(new_obj)
	# Your action here
	

				
func get_aligned_grid_position(grid_coords: Vector2i, size: Vector2) -> Vector2:
	var pos = grid_origin + grid_coords * grid_size
	pos.x += (grid_size - size.x) / 2
	pos.y += grid_size - size.y
	return pos
	
func get_cell_rect(grid_coords: Vector2i) -> Rect2:
	var top_left = Vector2i(grid_coords) * grid_size + grid_origin
	return Rect2(top_left, Vector2i(grid_size, grid_size))
	
func center_on_camera():
	var camera_center = main_camera.get_screen_center_position()
	var grid_pixel_size = Vector2(columns * grid_size, rows * grid_size)
	grid_origin = camera_center - (grid_pixel_size / 2)


func spawn_on_grid(grid_coords: Vector2i, obj_scene: PackedScene):
	var new_obj = obj_scene.instantiate()
	new_obj.position = Vector2i(grid_coords) * grid_size + grid_origin
	add_child(new_obj)

func spawn_random_object():
	var item = pick_weighted_item()
	var grid_coords = Vector2i(randi() % columns, randi() % rows)
	spawn_on_grid(grid_coords, item["obj"])

func pick_weighted_item():
	var total = 0.0
	for i in items:
		total += i.chance

	var rand_val = randf() * total
	var running_sum = 0.0
	for i in items:
		running_sum += i.chance
		if rand_val <= running_sum:
			return i
	return items[0]  # fallback
	
func add_point():
	score += 1
	score_label.text = str(score) + " Coins"
