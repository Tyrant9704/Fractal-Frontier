extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_classic_pressed():
	get_tree().change_scene_to_file("res://scenes/loading_screen/loading_screen.tscn")
	global.gameplay_scene = "classic_mode"


func _on_open_world_pressed():
	pass
	#get_tree().change_scene_to_file("res://scenes/loading_screen/loading_screen.tscn")
	#global.gameplay_scene = 'open_world_mode'
