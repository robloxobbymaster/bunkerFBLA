class_name Wire extends Node2D

signal just_moved

var default_position: Vector2 = Vector2(52,16)

var is_on: bool = false
var is_holding: bool = false
@export var can_move: bool = true

@onready var pos: Vector2 = %Endpoint.global_position:
	set(value):
		pos = value
		if can_move:
			%Endpoint.global_position = value
			%Line2D.points[1] = %Line2D.to_local(value)
			just_moved.emit()
			
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
				


func _process(_delta: float) -> void:
	if is_on and is_holding and can_move:
		pos = get_global_mouse_position()
	elif can_move:
		reset_endpoint()
func move_endpoint(target_pos: Vector2) -> void:
	pos = target_pos

func reset_endpoint() -> void:
	move_endpoint(%StartPoint.global_position+Vector2(40,40))
	
	
func rest() -> void:
	reset_endpoint()
	can_move = true
	is_on = false
	is_holding = false
