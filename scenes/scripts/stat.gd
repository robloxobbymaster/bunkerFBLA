extends TextureProgressBar
class_name statParent

@export var degration: float = 0.5:
	set(value):
		degration = value

@export var val: float = 100:
	set(value):
		val = value
		var tween = create_tween()
		tween.tween_property($".", "value", value, 1)

func _process(_delta: float) -> void:
	$".".value = val
	

func _on_degration_timer_timeout() -> void:
	val -= degration
