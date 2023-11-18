extends Resource
class_name user_settings

@export_range(0, 1, .05) var music_level: float =  1.0
@export_range(0, 1, .05) var sfx_level: float =  1.0


func save():
	ResourceSaver.save(self, 'user://saves/user_settings.tres')
	
static func load_or_create() -> user_settings:
	var res: user_settings = load('user://saves/user_settings.tres') as user_settings
	if !res:
		res = user_settings.new()
	return res
