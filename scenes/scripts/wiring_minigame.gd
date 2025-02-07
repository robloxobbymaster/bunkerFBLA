extends Node2D

signal completed

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
			completed.emit()
			AudioManager.play(AudioManager.SoundIds.SUCCESS_SFX)

@onready var Recievers: Array[Node] = %Recievers.get_children()
@onready var Wires: Array[Node] = %Wires.get_children()

func refresh() -> void:
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
		
func _ready() -> void:
	refresh()
	GameManager.isInMinigame = true
	
	
func rest() -> void:
	for wire in Wires: wire.rest()
	for reciever in Recievers: reciever.reset()
	amt_connected = 0
	topWire = null
