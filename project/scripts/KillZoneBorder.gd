extends Area2D



@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var areas: Node = $"../../Areas"


@onready var game_manager: Node = %GameManager
var score = 0


func _on_body_entered(body: Node2D) -> void:
	game_manager.game_over("Fail")

 # Replace with function body.
