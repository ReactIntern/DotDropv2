extends Node
var screen_size: Vector2
#var camera_width = 560
#var camera_height = 800
var platform = preload('res://scenes/platform.tscn')
var coin = preload("res://scenes/coin.tscn")
var EnemyPlat = preload('res://MiniScenesFolder/EnemyPlat.tscn')
var speed = 30
var spawn_interval = 1.0
var spawn_timer: Timer
var spawned_positions = []
var width
var height
var List = [platform, EnemyPlat]
@onready var player: CharacterBody2D = $"../Player"
var current_spawn_y = 0.0 
@onready var timer: Timer = $"../Timer"
var score = 0
@onready var score_label: Label = $ScoreLabel
var items = [
	{"obj": EnemyPlat, "chance": 0.5},
	{"obj": platform, "chance": 0.7},
	#{"obj": Slime, "chance": 0.3},
	{"obj": coin, "chance": 0.3}
#{"obj": Blade, "chance": 0.1}
	#{"obj": BreakPlat, "chance": 0.3}
	#{"obj": , "chance": 0.}
]
#new code
const GRID_CELL_SIZE = 64  # space between objects
const ColsX = 5       # number of columns
const RowsY = 12      # number of rows
const GRID_OFFSET = Vector2(200, 250)  # where the grid starts in the world

func generate_grid_positions(cell_size: int, cols: int, rows: int, offset: Vector2) -> Array:
	var positions = []
	for x in range(cols):
		for y in range(rows):
			var pos = Vector2(x * cell_size, y * cell_size) + offset
			positions.append(pos)
	return positions

func scale_object_to_screen(obj: Node2D, reference_size: Vector2):
	var screen = get_viewport().get_visible_rect().size
	var scale_factor = screen.x / reference_size.x
	obj.scale = Vector2(scale_factor, scale_factor)
	
func add_point():
	score += 1
	score_label.text = str(score) + " Coins"


func is_position_clear(pos: Vector2, min_distance: float) -> bool:
	for existing_pos in spawned_positions:
		if pos.distance_to(existing_pos) < min_distance:
			return false
	return true
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	print("Screen size:", screen_size)
	var grid_positions = generate_grid_positions(GRID_CELL_SIZE, ColsX, RowsY, GRID_OFFSET)
	grid_positions.shuffle()

	for i in range(min(12, grid_positions.size())):
		var pos = grid_positions[i]

		# Spawn platform
		var new_platform = platform.instantiate()
		scale_object_to_screen(new_platform, Vector2(560, 800))
		add_child(new_platform)

		# Maybe spawn a coin or enemy on it
		if randi() % 2 == 0:
			var obj = List.pick_random().instantiate()
			obj.position = pos + Vector2(randf_range(-4, 4), randf_range(-4, 4))
			add_child(obj)


func _on_spawn_timer_timeout() -> void:
	#randomize()
	print('called')
	var y= 0
	#while y > -3000:
	for i in range(12):
		var new_platform = platform.instantiate()
		new_platform.position = Vector2(randf_range(-60, 47),randf_range(65, 700))#randf_range(-60, 47), randf_range(-108, 86))
		add_child(new_platform)
	for i in range(3):
		var new_coin = coin.instantiate()
		new_coin.position = Vector2(randf_range(-60, 47),randf_range(65, 900))#randf_range(-60, 47), randf_range(-108, 86))
		add_child(new_coin)
		y -= randf_range(210, 500)
		
		
	 # Replace with function body.
