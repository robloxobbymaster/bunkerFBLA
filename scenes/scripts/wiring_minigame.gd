extends Node2D

var topWire: Wire
#All three arrays must be the same size!
var Colors: Array[Color] = [
	Color.RED,
	Color.BLUE,
	Color.YELLOW,
	Color.GREEN,
	Color.ORANGE,
]

var amt_connected: int = 0

@onready var Recievers: Array[Node] = %Recievers.get_children()
@onready var Wires: Array[Node] = %Wires.get_children()

func refresh() -> void:
	amt_connected = 0
	topWire = null
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
			if topWire:
				topWire.z_index = 0
			topWire = wire
			topWire.z_index = 1
			)
			
		reciever.connected.connect(func():
			amt_connected+=1
			)
		
func _ready() -> void:
	refresh()
