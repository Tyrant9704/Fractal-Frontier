extends HBoxContainer

@export var health_point = PackedScene.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	setup_health()

func setup_health():
	for i in range(global.lives):
		add_child(health_point.instantiate())


func remove_health():
	if (get_child_count() >0):
		get_child(get_child_count() -1).queue_free()
