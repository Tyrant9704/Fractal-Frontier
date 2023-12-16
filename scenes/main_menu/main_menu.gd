extends Control

var user_pref = user_settings
@onready var music = get_tree().get_root().get_node("/root/music_handler")

var music_bus = AudioServer.get_bus_index('music')
var sfx_bus = AudioServer.get_bus_index('sfx')
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play('title_pulse')
	if music:
		if music.gameplay_music.is_playing():
			music.gameplay_music.stop()
		if !music.menu_music.is_playing():
			music.menu_music.play()

	SaveFile.load_game()
	
	user_pref = user_pref.load_or_create()
	
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(user_pref.music_level))
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(user_pref.sfx_level))
	
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/mode_select.tscn")
	music.menu_music.stop()



func _on_button_3_pressed():
	get_tree().quit()


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/options/options.tscn")
