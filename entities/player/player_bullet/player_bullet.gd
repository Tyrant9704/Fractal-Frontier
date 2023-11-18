extends Area2D
class_name player_bullet

var speed = 1500

# 1Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	position += transform.x * speed * delta

	var viewport_rect = get_viewport().get_visible_rect()

	if position.x > viewport_rect.size.x:
		position.x = 0
	elif position.x < 0:
		position.x = viewport_rect.size.x

	if position.y > viewport_rect.size.y:
		position.y = 0
	elif position.y < 0:
		position.y = viewport_rect.size.y



func _on_timer_timeout():
	queue_free()


