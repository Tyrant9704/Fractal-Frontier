extends Node
class_name saver


var save_file = 'user://saves/save.json'
var dir = 'user://saves'

var scoreboard = {}

var str_dict = {}

func _ready():
	load_game()
	
func save_game():
	
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	var json_data = JSON.stringify(scoreboard)
	file.store_line(json_data)
	file.close()

	
func load_game():
	if not DirAccess.dir_exists_absolute(dir):
		DirAccess.make_dir_recursive_absolute(dir)
	if not FileAccess.file_exists(save_file):
		scoreboard = {
		210: 'LAS',
		2090 : 'POR',
		11610 : 'GOD',
		2190 : 'ASD',
		6805: 'DFG',
		3040: 'PMK',
		670: 'ASB',
		}
		save_game()
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file, FileAccess.READ)
		var text = file.get_as_text(true)
		var j = JSON.new()
		file.close()
		scoreboard = j.parse_string(text)
	
