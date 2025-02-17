extends CanvasLayer

class_name ui
signal game_started
var game_points = 0 

@onready var end_of_game_screen = $end_of_game_screen

func _ready():
	end_of_game_screen.visible = false
	
func updated_points(points: int):
	print('ui points:', points)
	game_points = points 
	
func game_over(Result):
	if Result != "Fail": 
		$end_of_game_screen/RestartButton/Sprite2D/Label.text = "You WON! Replay?"
		
		
	end_of_game_screen.visible = true
	$end_of_game_screen/end_game_score_display/points.text =  "%d" % game_points 

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scripts/level1.tscn")
