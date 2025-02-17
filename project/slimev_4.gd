extends Node2D
@onready var game_manager: Node = %GameManager
const SPEED = 60
var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not ray_cast_right.is_colliding()  and direction == 1:
		direction = -1
		animated_sprite.flip_h = true
	if not ray_cast_left.is_colliding() and direction == -1:
		direction = 1
		animated_sprite.flip_h = false
	
	position.x += direction * SPEED * delta
	
	



func _on_body_entered(body: Node2D) -> void:
	game_manager.game_over("Fail") # Replace with function body.
