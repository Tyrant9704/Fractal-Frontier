extends Control

var sfx_bus = AudioServer.get_bus_index('sfx')
var music_bus = AudioServer.get_bus_index('music')
@onready var music_slider = $pause_menu/pause_popup/music_slider
@onready var sfx_slider =  $pause_menu/pause_popup/sfx_slider
@onready var Music = get_tree().get_root().get_node("/root/music_handler")
var user_pref = user_settings


func _ready():
	user_pref = user_pref.load_or_create()
	if music_slider:
		music_slider.value = user_pref.music_level
	if sfx_slider:
		sfx_slider.value = user_pref.sfx_level
	
	if !Music.gameplay_music.is_playing():
		Music.gameplay_music.play()
	else:
		pass
	

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	AudioServer.set_bus_mute(music_bus, value < .05)
	if user_pref:
		user_pref.music_level = value
		user_pref.save()

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(value))
	AudioServer.set_bus_mute(sfx_bus, value < .05)
	if user_pref:
		user_pref.sfx_level = value
		user_pref.save()


func _on_back_to_menu_pressed():
	Music.gameplay_music.stop()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
