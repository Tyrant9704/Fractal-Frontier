extends Control

@onready var scene = "res://scenes/GUI/gameplay_scene.tscn"
@onready var sfx = "res://scripts/sfx.tscn"
@onready var progress_bar: TextureProgressBar = $VBoxContainer/HBoxContainer/TextureProgressBar
var progress = []
var progress1 = []
var scene_load_status = 0
var sfx_load_status = 0


func _ready():
	ResourceLoader.load_threaded_request(scene)
	ResourceLoader.load_threaded_request(sfx)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene, progress)
	sfx_load_status = ResourceLoader.load_threaded_get_status(sfx, progress1)
	progress_bar.value = (progress[0] + progress1[0]) * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		if sfx_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var sfx_scene = ResourceLoader.load_threaded_get(sfx)
			if sfx_scene:
				var sfx_instance = sfx_scene.instantiate()
				get_tree().get_root().add_child(sfx_instance)
				await get_tree().create_timer(.3).timeout
				get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
