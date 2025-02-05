extends Control

var hoveringOver: bool = false

var end_point: Vector2 = Vector2.ZERO:
	set(value):
		end_point = value
		%red_wire.points[1] = value
		%red_wire.get_node("Area2D/CollisionShape2D").shape.b = value/%red_wire.get_node("Area2D").scale.x

func _process(delta: float) -> void:
	end_point = get_local_mouse_position()
	


func _on_area_2d_mouse_entered() -> void:
	print("hi!")
	hoveringOver = true
	
func _on_area_2d_mouse_exited() -> void:
	hoveringOver = false
