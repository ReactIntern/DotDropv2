extends Node2D
var platform = preload('res://scenes/platformtwo.tscn')
var EnemyPlat = preload("res://scenes/EnemyPlat.tscn")
var speed = 10
var platforms = []
var CanScroll = false
var List = [platform, EnemyPlat]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous
func _physics_process(delta: float) -> void:
	#pass
	if (CanScroll == false):
		for area in $ScrollArea.get_children():
			if not area is Label:
				area.position.y -= speed*delta
				
func stopScroll():
	CanScroll = true


func _on_slimev_4_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
