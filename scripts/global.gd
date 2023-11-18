extends Node

var score: int
var lives: int
var explosion = preload("res://scripts/explosion_line.tscn")
# Called when the node enters the scene tree for the first time.

func _ready():
	lives = 3
	score = 0
	
	
func _process(delta):
	if Input.is_action_just_pressed("debug_key"):
		SaveFile.load_game()
		print(SaveFile.scoreboard_classic)
	if Input.is_action_just_pressed("debug_key_1"):
		SaveFile.save_game()
		print(SaveFile.scoreboard_classic)

func explosion_handler(object_pos):
	for i in range(6):
		var range = 100
		var random_angle = randf() * 2 * PI
		var offset_x = cos(random_angle) * range
		var offset_y = sin(random_angle) * range
		var random_point = Vector2(object_pos.x + offset_x, object_pos.y + offset_y)
		var explode = explosion.instantiate()
		get_parent().add_child(explode)
		explode.explosion(object_pos, random_point)
		
func reset():
	lives = 3
	score = 0
