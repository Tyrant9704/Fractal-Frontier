extends Control

@onready var scene = "res://scenes/GUI/gameplay_scene.tscn"
@onready var progress_bar: TextureProgressBar = $VBoxContainer/HBoxContainer/TextureProgressBar
var progress = []
var scene_load_status = 0


func _ready():
	ResourceLoader.load_threaded_request(scene)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene, progress)
	progress_bar.value = progress[0] * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
