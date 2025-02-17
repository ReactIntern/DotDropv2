extends Node

@onready var ui: ui = $"../UI"
@onready var score_label: Label = $"../Areas/ScoreLabel"
@onready var game: Node2D = $".."

var score = 0

func add_point():
	
	score += 1
	score_label.text = str(score) + " Coins"
	ui.updated_points(score)

func game_over(Result):
	print('call ui game over')
	game.stopScroll()
	ui.game_over(Result)
