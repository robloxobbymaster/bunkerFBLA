extends NinePatchRect

var queue = [];


func display(text: String = "....", displayName: String = "?????", icon: Image = null, typingSpeed: float = 0.15) -> int:
	%Dialog.text = ""
	
	var splittedText := text.split("")
	
	for character in splittedText:
		%Dialog.text+=character
		await get_tree().create_timer(typingSpeed).timeout
		AudioManager.play(AudioManager.SoundIds.DIALOG)
	
	return 0


func _ready() -> void:
	await get_tree().create_timer(3).timeout
	display()
