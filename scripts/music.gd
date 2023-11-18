extends Node


@onready var explosion = $explosion
@onready var laser = $laser
@onready var power_down = $power_down
@onready var engine = $engine
@onready var laser_2 = $laser_2
@onready var menu_music = $menu_music
@onready var gameplay_music = $gameplay_music


func _on_menu_music_finished():
	menu_music.play()


func _on_gameplay_music_finished():
	gameplay_music.play()
