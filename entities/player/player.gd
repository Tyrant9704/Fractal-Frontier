extends CharacterBody2D
class_name player

var speed = 150  # move speed in pixels/sec
var acceleration = 0.1
var friction = 0.01
var target_rotation = 0
var rotating = 0

var value = 0
var rotation_speed = 10


var is_respawned = false
var is_immortal = false
var is_alive = true
var respawn_point = Vector2(480, 270)

@onready var player_bullet = preload("res://entities/player/player_bullet/player_bullet.tscn") 
@onready var muzzle = $muzzle
@onready var sfx = get_tree().get_root().get_node("/root/sfx")

func _ready():
	global_position = respawn_point

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('up'):
		sfx.engine.play()
		input.y +=1
		$AnimationPlayer.play("fly")
	else:
		sfx.engine.stop()

	if Input.is_action_just_pressed("shoot"):
		_shoot()
	return input
	
func _process(delta):
	if is_alive == true:
		var direction = get_input()
	
		if direction.length() > 0:
			velocity = velocity.lerp(transform.x.normalized() * speed, acceleration)
		else:
			velocity = velocity.lerp(Vector2.ZERO, friction)
		move_and_slide()
		
	
	
		if Input.is_action_pressed("left"):
			value = rotation + -rotation_speed * delta
			rotation = lerp_angle(rotation, value, 0.5)
		if Input.is_action_pressed("right"):
			value = rotation + rotation_speed * delta
			rotation = lerp_angle(rotation, value, 0.5)


func _shoot():
	var bullet = player_bullet.instantiate()
	get_parent().add_child(bullet)
	bullet.global_transform = muzzle.global_transform
	sfx.laser_2.play()


func _on_area_2d_area_entered(area):
	is_alive = false
	_death()


func _death():
	sfx.power_down.play()
	sfx.engine.stop()
	var player_pos = position
	global.lives -= 1
	global.explosion_handler(player_pos)
	get_tree().get_root().get_node('hud/health_bar').remove_health()
	if global.lives > 0:
		global_position = respawn_point
		rotation_degrees = 270
		call_deferred('respawn')
	else:
		get_tree().change_scene_to_file("res://scenes/score_board/score_board.tscn")
		get_tree().get_root().get_node("/root/hud").queue_free()

func respawn():
	$Area2D/CollisionPolygon2D.disabled = true
	visible = false
	$respawn_countdown.start()
	



func _on_respawn_countdown_timeout():
	visible = true
	$immortality_countdown.start()
	is_alive = true
	velocity = Vector2.ZERO
	$immortality.play("immortality")


func _on_immortality_countdown_timeout():
	$Area2D/CollisionPolygon2D.disabled = false


