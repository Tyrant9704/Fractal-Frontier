extends MeshInstance2D

func explosion(pos1, pos2):
	
	var draw_mesh = ImmediateMesh.new()
	mesh = draw_mesh
	draw_mesh.surface_begin(Mesh.PRIMITIVE_LINES)
	draw_mesh.surface_set_color(Color.from_ok_hsl(0.51, 0.99, 0.51))
	draw_mesh.surface_add_vertex_2d(pos1)
	draw_mesh.surface_add_vertex_2d(pos2)
	draw_mesh.surface_end()


func _on_timer_timeout():
	queue_free()
