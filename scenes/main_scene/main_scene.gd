extends Node2D

var screen_width 
var screen_height 
var min_distance_from_player = 200

@export var num_random_points = 3
var default_number_of_points = 3
var loop_count = 0
@export var loop_destination = 4

var explosion = preload("res://scripts/explosion_line.tscn")
var pressed

@onready var Music = get_tree().get_root().get_node("/root/music_handler")
@onready var p = $player

func _ready():
	randomize()
	screen_width = int(get_viewport_rect().size.x)
	screen_height = int(get_viewport_rect().size.y)
	num_random_points = default_number_of_points
	
	
func _process(delta):
	var asteroids_count = get_tree().get_nodes_in_group('asteroids')
	if asteroids_count.size() == 0:
		start_game()
		
	
	if p.global_position.x > get_viewport_rect().size.x:
		p.global_position.x = 0
	elif p.global_position.x < 0:
		p.global_position.x = get_viewport_rect().size.x

	if p.global_position.y > get_viewport_rect().size.y:
		p.global_position.y = 0
	elif p.global_position.y < 0:
		p.global_position.y = get_viewport_rect().size.y
		
func start_game():
	# Generate random points at the beginning of the game and spawn enemies on these points
	var random_points = generate_random_points(num_random_points)
	spawn_enemies(random_points)
	loop_count += 1
	if loop_count == loop_destination:
		num_random_points += 1
		loop_count = 0

func generate_random_points(num_points):
	var points = []
	
	for i in range(num_points):
		var random_x = randi() % screen_width
		var random_y = randi() % screen_height
		
		
		# Ensure the random point is not within the specified radius from the player
		var player_position = $player.global_position
		
		while player_position.distance_to(Vector2(random_x, random_y)) < min_distance_from_player:
			random_x = randi() % screen_width
			random_y = randi() % screen_height
	
		points.append(Vector2(random_x, random_y))
	
	return points

func spawn_enemies(points):
	for point in points:
		var enemy = preload("res://entities/asteroid/asteroid.tscn").instantiate()
		enemy.position = point
		get_tree().get_root().call_deferred("add_child", enemy)
		
		
func explosion_handler(asteroid_pos):
	for i in range(6):
		var range = 100
		var random_angle = randf() * 2 * PI
		var offset_x = cos(random_angle) * range
		var offset_y = sin(random_angle) * range
		var random_point = Vector2(asteroid_pos.x + offset_x, asteroid_pos.y + offset_y)
		var explode = explosion.instantiate()
		add_child(explode)
		explode.explosion(asteroid_pos, random_point)
		




func _on_tree_exiting():
	for child in get_tree().get_nodes_in_group('asteroids'):
		child.queue_free()
	loop_count = 0
	num_random_points = default_number_of_points
	
	get_tree().get_root().get_node('sfx').queue_free()
		
	

