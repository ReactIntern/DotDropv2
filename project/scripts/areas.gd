extends Node

var camera_width = 560
var camera_height = 800
var platform = preload('res://scenes/platform.tscn')
var coin = preload("res://scenes/coin.tscn")
var speed = 30
var spawn_interval = 1.0
var spawn_timer: Timer
var width
var height
@onready var player: CharacterBody2D = $"../Player"
@onready var timer: Timer = $"../Timer"
var score = 0
@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1
	score_label.text = str(score) + " Coins"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
	
	# Set up the timer for continuous platform spawning
	# Get the Timer node
	# Connect the timeout signal
	#spawn_timer.connect("timeout", self, "_on_timer_timeout")
		
# Called every frame. 'delta' is the elapsed time since the previous frame.


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
