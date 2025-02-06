extends Sprite2D

@export var connector: Wire
@export var is_connected: bool = false


func _on_area_2d_body_entered(body: Node2D) -> void:
	print("AHH!!")


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var wire: Wire = area.get_parent().get_parent()
	if wire == connector:
		wire.move_endpoint(get_node("Area2D").global_position)
		wire.can_move = false
		is_connected = true
