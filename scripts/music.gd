extends Node


@onready var explosion = $explosion

@onready var menu_music = $menu_music
@onready var gameplay_music = $gameplay_music


func _on_menu_music_finished():
	menu_music.play()


func _on_gameplay_music_finished():
	gameplay_music.play()
