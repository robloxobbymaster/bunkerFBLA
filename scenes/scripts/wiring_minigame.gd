class_name Wiring_Minigame extends Node2D

signal completed

var shown_pos: Vector2 = Vector2.ZERO

var hidden_pos: Vector2 = Vector2(0,720)

var target_pos: Vector2 = hidden_pos

var SPEED: int = 8
func show_minigame() -> void: 
	target_pos = shown_pos
	refresh()
func hide_minigame() -> void: 
	target_pos = hidden_pos

var topWire: Wire
#All three arrays must be the same size!
var Colors: Array[Color] = [
	Color.RED,
	Color.BLUE,
	Color.YELLOW,
	Color.GREEN,
	Color.ORANGE,
]

var amt_connected: int = 0:
	set(value):
		amt_connected = value
		if(amt_connected == Colors.size()):
			GUI.show_completion()
			await get_tree().create_timer(1.5).timeout
			
			GUI.hide_completion(12)
			GameManager.isInMinigame = false
			completed.emit()
			hide_minigame()
			GameManager.lights_on.emit()

@onready var Recievers: Array[Node] = %Recievers.get_children()
@onready var Wires: Array[Node] = %Wires.get_children()


	
func reset() -> void:
	for wire in Wires: wire.reset()
	for reciever: Reciever in Recievers: 
		reciever.reset()
		for sig in reciever.connected.get_connections():
			reciever.connected.disconnect(sig.callable)
	amt_connected = 0
	topWire = null

func refresh() -> void:
	reset()
	GameManager.isInMinigame = true
	Recievers.shuffle()
	Wires.shuffle()
	Colors.shuffle()
	
	for n in range(Colors.size()):
		var reciever: Reciever = Recievers[n]
		var wire: Wire = Wires[n]
		var color: Color = Colors[n]
		
		reciever.connector = wire
		reciever.modulate = color
		wire.modulate = color
		
		wire.just_moved.connect(func():
			if topWire != null:
				topWire.z_index = 0
			topWire = wire
			topWire.z_index = 2
			)
			
		reciever.connected.connect(func():
			amt_connected+=1
			)
		
	



func _process(delta: float) -> void:
	global_position = lerp(global_position, target_pos, delta*SPEED)
