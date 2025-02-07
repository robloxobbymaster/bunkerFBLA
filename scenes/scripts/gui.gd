extends CanvasLayer

var show_pos: Vector2 = Vector2(380, 263)
var hidden_pos: Vector2 = Vector2(380, 680)

var target_pos: Vector2 = hidden_pos

@export var SPEED: int = 5

func reapplyValues() -> void:
	%Health.value = GameManager.HEALTH
	%Hunger.value = GameManager.HUNGER
	%Thirst.value = GameManager.THIRST
	%Time.text = "[b]Time: %.2f[/b]" % GameManager.TIME_ELAPSED 

func show_completion() -> void:
	AudioManager.play(AudioManager.SoundIds.SUCCESS_SFX)
	target_pos =  show_pos
	
func hide_completion() -> void:
	target_pos = hidden_pos

func _process(delta: float) -> void:
	%CompletedLabel.global_position = lerp(%CompletedLabel.global_position,target_pos, delta*SPEED)
