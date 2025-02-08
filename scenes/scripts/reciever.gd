class_name Reciever extends Sprite2D

@export var connector: Wire
@export var is_connected: bool = false

signal connected




func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var wire= area.get_parent().get_parent()
	if wire == connector:
		wire.move_endpoint(get_node("Area2D").global_position)
		wire.can_move = false
		is_connected = true
		AudioManager.play(AudioManager.SoundIds.WIRE_CLICK)
		connected.emit()


func reset() -> void:
	is_connected = false
	connector = null
