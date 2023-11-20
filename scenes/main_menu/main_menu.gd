extends Control

@onready var Music = get_tree().get_root().get_node("/root/music_handler")
# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play('title_pulse')
	if Music:
		if Music.gameplay_music.is_playing():
			Music.gameplay_music.stop()
		if !Music.menu_music.is_playing():
			Music.menu_music.play()

	SaveFile.load_game()
	

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/loading_screen/loading_screen.tscn")
	Music.menu_music.stop()



func _on_button_3_pressed():
	get_tree().quit()


func _on_button_2_pressed():
	get_tree().change_scene_to_file("res://scenes/options/options.tscn")
