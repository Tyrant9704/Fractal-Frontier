extends Control

var sfx_bus = AudioServer.get_bus_index('sfx')
var music_bus = AudioServer.get_bus_index('music')
@onready var music_slider = $pause_popup/music_slider
@onready var sfx_slider = $pause_popup/sfx_slider


var user_pref = user_settings


func _ready():
	user_pref = user_pref.load_or_create()
	if music_slider:
		music_slider.value = user_pref.music_level
	if sfx_slider:
		sfx_slider.value = user_pref.sfx_level
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


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
