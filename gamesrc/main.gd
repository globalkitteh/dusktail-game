extends Node2D

var found_crown_1 = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pile_body_entered(body: Node2D) -> void:
	if found_crown_1 > 0:
		get_tree().change_scene_to_file("res://main2.tscn")


func _on_crown_body_entered(body: Node2D) -> void:
	found_crown_1 = 1
	

	
