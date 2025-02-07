extends Node

var SoundIds = {
	DIALOG = load("res://soundEffects/dialogSoundEffect.mp3"),
	SELECT_SOUND = load("res://soundEffects/selectSoundEffect.mp3"),
	WIRE_CLICK = load("res://soundEffects/wireClick.mp3"),
	SUCCESS_SFX = load("res://soundEffects/successSFX.mp3")
}

func play(audio: AudioStream, volume: float = 0.75) -> void:
	var newSound: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	newSound.stream = audio
	newSound.volume_db = volume
	
	add_child(newSound)
	newSound.play()
	
	newSound.finished.connect(func():
		newSound.queue_free()
		)
	
	return
