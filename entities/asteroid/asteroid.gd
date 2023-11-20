extends Area2D
class_name asteroid

var max_speed = 100
var asteroid = load("res://entities/asteroid/asteroid.tscn")
@onready var Music = get_tree().get_root().get_node("/root/music_handler")
var size = 3


func _ready():
	randomize()
	rotation_degrees = randf_range(0, 360)
	size -=1
	
var direction = Vector2(randf() * 2 -1, randf() *2 -1).normalized()

func _process(delta):
	if position.x > get_viewport_rect().size.x:
		position.x = 0
	elif position.x < 0:
		position.x = get_viewport_rect().size.x

	if position.y > get_viewport_rect().size.y:
		position.y = 0
	elif position.y < 0:
		position.y = get_viewport_rect().size.y
		
	
	position += direction * max_speed * delta
	


func _on_area_entered(area):
	if area is player_bullet:
		Music.explosion.play()
		area.queue_free()
		var pos = position
		var score 
		global.explosion_handler(pos)
		if scale > Vector2(1,1):
			fragments()
		else:
			queue_free()
		queue_free()
		
		if scale == Vector2(3,3):
			global.score += 20
		if scale == Vector2(2,2):
			global.score += 50
			max_speed += 40
		if scale == Vector2(1,1):
			global.score += 100
			max_speed += 50
			
		
		
		
func fragments():
	for i in range(3):
		var asteroid_child = asteroid.instantiate()
		get_tree().get_root().call_deferred("add_child", asteroid_child)
		asteroid_child.position = position
		asteroid_child.scale = scale - Vector2(1,1)
		
func pos() -> Vector2:
	return global_position
	

