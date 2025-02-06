extends Node2D


var is_on: bool = false
var is_holding: bool = false

@onready var pos: Vector2 = %Endpoint.global_position:
	set(value):
		pos = value
		%Endpoint.position = value
		%Line2D.points[1] = %Line2D.to_local(value)


func _on_area_2d_mouse_entered() -> void:
	is_on = true

func _on_area_2d_mouse_exited() -> void:
	is_on = false
	
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and is_on:
		if event.button_index == 1 and event.is_pressed():
			is_holding = true
		elif event.button_index == 1 and not event.is_pressed():
			is_holding = false


func _process(delta: float) -> void:
	if is_on and is_holding:
		pos = get_global_mouse_position()
