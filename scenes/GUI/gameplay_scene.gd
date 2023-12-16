extends Control

var sfx_bus = AudioServer.get_bus_index('sfx')
var music_bus = AudioServer.get_bus_index('music')
@onready var music_slider = $pause_menu/pause_popup/music_slider
@onready var sfx_slider =  $pause_menu/pause_popup/sfx_slider
@onready var Music = get_tree().get_root().get_node("/root/music_handler")
var user_pref = user_settings

var pressed

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
	
	global.reset()
	
func _process(delta):
	$Label.text = var_to_str(global.score)

	

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
	self.queue_free()


func _on_pause_button_pressed():
	pressed = !pressed
	
	if pressed:
		$buttons.visible = false
		$buttons_2.visible = false
		$Label.visible = false
		$health_bar.visible = false
		$pause_menu.visible = true
		get_tree().paused = true
	else:
		$buttons.visible = true
		$buttons_2.visible = true
		$Label.visible = true
		$health_bar.visible = true
		$pause_menu.visible = false
		get_tree().paused = false
