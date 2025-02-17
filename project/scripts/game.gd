extends Node2D
var platform = preload('res://scenes/platformtwo.tscn')
var speed = 42
var platforms = []
var CanScroll = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
		
	#for y in range(300):
	#	pass
	#	var new_platform = platform.instance()
		#new_platform.set_position(Vector2(0,y))
		#add_child(new_platform)
		#y -= randf_range(0,210)# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous
func _physics_process(delta: float) -> void:
	#pass
	if (CanScroll == false):
		for area in $Areas.get_children():
			if not area is Label:
				area.position.y -= speed*delta
				
func stopScroll():
	CanScroll = true


func _on_slimev_4_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
