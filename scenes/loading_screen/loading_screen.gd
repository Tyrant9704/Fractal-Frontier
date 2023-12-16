extends Control

@onready var hud = "res://scenes/GUI/hud.tscn" ##hud only!
@onready var open_world = "res://scenes/open world/open_world.tscn" ##open world
@onready var sfx = "res://scripts/sfx.tscn" ##sound effects
@onready var classic_game = "res://scenes/main_scene/main_scene.tscn" #classic asteroid

@onready var progress_bar: TextureProgressBar = $VBoxContainer/HBoxContainer/TextureProgressBar

var progress = [] # for hud
var progress1 = [] #for sfx
var progress2 = [] # for scenes

var hud_load_status = 0 #for hud
var sfx_load_status = 0 #for sfx
var classic_load_status = 0 #for classic asteroid scene
var open_load_status = 0 #for open world scene 





func _ready():
	ResourceLoader.load_threaded_request(hud)
	ResourceLoader.load_threaded_request(sfx)
	
	if global.gameplay_scene == 'classic_mode': #setting request to classic
		ResourceLoader.load_threaded_request(classic_game)
	if global.gameplay_scene == 'open_world_mode':
		ResourceLoader.load_threaded_request(open_world)


func _process(delta):
	#getting scenes that we want to load
	hud_load_status = ResourceLoader.load_threaded_get_status(hud, progress)
	sfx_load_status = ResourceLoader.load_threaded_get_status(sfx, progress1)
	if global.gameplay_scene == 'classic_mode':
		classic_load_status = ResourceLoader.load_threaded_get_status(classic_game, progress2)
	if global.gameplay_scene == 'open_world_mode':
		open_load_status = ResourceLoader.load_threaded_get_status(open_world, progress2)
	
	#getting progress visible on progress bar
	progress_bar.value = (progress[0] + progress1[0] + progress2[0]) * 100
	
	#loading
	if hud_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		if sfx_load_status == ResourceLoader.THREAD_LOAD_LOADED:
			var sfx_scene = ResourceLoader.load_threaded_get(sfx)
			if sfx_scene:
				var sfx_instance = sfx_scene.instantiate()
				get_tree().get_root().add_child(sfx_instance)
			
		var hud_scene = ResourceLoader.load_threaded_get(hud)
		if hud_scene:
			var hud_instance = hud_scene.instantiate()
			get_tree().get_root().add_child(hud_instance)
			if global.gameplay_scene == 'classic_mode':
				var classic_game_scene = ResourceLoader.load_threaded_get(classic_game)
				if classic_game_scene:
					var classic_game_instance = classic_game_scene.instantiate()
					get_tree().get_root().get_node('/root/hud').add_child(classic_game_instance)
			if global.gameplay_scene == 'open_world_mode':
				var open_world_scene = ResourceLoader.load_threaded_get(open_world)
				if open_world_scene:
					var open_world_instance = open_world_scene.instantiate()
					get_tree().get_root().get_node('/root/hud').add_child(open_world_instance)
					
	await get_tree().create_timer(.3).timeout
	
	get_tree().get_root().get_node('/root/hud').visible = true
	get_tree().get_root().get_node('/root/hud').set_process_input(true)
	get_tree().get_root().get_node('/root/loading_screen').queue_free() 
				
				#get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(hud))
