extends Control

@onready var scene = 'res://scenes/main_menu/main_menu.tscn'
@onready var  music ="res://scripts/music.tscn"
@onready var progress_bar: TextureProgressBar = $VBoxContainer/HBoxContainer/TextureProgressBar
var progress = []
var progress1 = []
var scene_load_status = 0
var music_load_status = 0



func _ready():
	ResourceLoader.load_threaded_request(scene)
	ResourceLoader.load_threaded_request(music)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	scene_load_status = ResourceLoader.load_threaded_get_status(scene, progress)
	music_load_status = ResourceLoader.load_threaded_get_status(music, progress1)
	progress_bar.value = (progress[0] + progress1[0]) * 100
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		if music_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var music_scene = ResourceLoader.load_threaded_get(music)
			if music_scene:
				var music_instance = music_scene.instantiate()
				get_tree().get_root().add_child(music_instance)
				await get_tree().create_timer(.5).timeout
				get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(scene))
