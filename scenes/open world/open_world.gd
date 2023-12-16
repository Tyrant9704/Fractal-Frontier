extends Node2D

@onready var p = $player

var last_player_pos = Vector2()

#calculating of player position
func get_player_tile_pos(player_pos: Vector2) -> Vector2:
	var player_tile_pos = $TileMap.local_to_map(player_pos)
	return player_tile_pos
	
#calculating neighboors
func get_neighboring_tiles(player_tile_pos: Vector2) -> Array:
	var neighboring_tiles = []
	for x in range(-1, 2):
		for y in range(-1, 2):
			neighboring_tiles.append(player_tile_pos + Vector2(x, y))
	return neighboring_tiles
	
	
func create_chunk(coordinates: Array):
	var chunk_scene = preload("res://scenes/chunk/chunk.tscn")
	var player_pos = p.position
	var player_tile_pos = get_player_tile_pos(player_pos)
	
	var active_chunks = get_neighboring_tiles(player_tile_pos)
	var existing_chunks = get_tree().get_nodes_in_group('chunk') # Pobierz aktualnie istniejące chunki
	
	# Usuń chunki spoza obszaru aktywnych chunków
	for existing_chunk in existing_chunks:
		if !active_chunks.has(existing_chunk.position / Vector2(1000, 1000)):
			existing_chunk.queue_free() 
			existing_chunks.erase(existing_chunk)
	
	# Instancjonuj nowe chunki
	for coord in active_chunks:
		var chunk_position = coord * Vector2(1000, 1000)
		var chunk_already_exists = false
		for existing_chunk in existing_chunks:
			if existing_chunk.position == chunk_position:
				chunk_already_exists = true
				break
		
		if !chunk_already_exists:
			var chunk_instance = chunk_scene.instantiate()
			chunk_instance.position = chunk_position
			add_child(chunk_instance)
			existing_chunks.append(chunk_instance)
			chunk_instance.add_to_group('chunk') # Dodaj nowy chunk do grupy, aby później móc go odnaleźć
			
	print(existing_chunks)




func _process(delta):
	
	$Camera2D.position = p.position

	
	var player_pos = p.position
	var player_tile_pos = get_player_tile_pos(player_pos)
	var tiles = get_neighboring_tiles(player_tile_pos)
	
	if player_tile_pos != last_player_pos:
		last_player_pos = player_tile_pos
		create_chunk(tiles)
	
func _ready():
	var player_pos = p.position
	var player_tile_pos = get_player_tile_pos(player_pos)
	var tiles = get_neighboring_tiles(player_tile_pos)
	

	create_chunk(tiles)
		


