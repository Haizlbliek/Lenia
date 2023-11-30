extends Node

var activeSumLeft: float    = 27.0
var activeSumRight: float   = 45.0
var unactiveSumLeft: float  = 29.0
var unactiveSumRight: float = 35.0
var smoothness: float = 0.02
var seedValue: int = 0
var lerping: bool = false

var presets: Array = [
	[27.0, 45.0, 29.0, 35.0, 0.02, 2],
	[23.6, 45.0, 29.0, 35.0, 0.02, 9],
	[31.0, 41.0, 32.9, 31.0, 0.1, 9],
]

var preset: int = 3
var seedRandomized: bool = true
var palette: int = 2

var mainPlayer: AudioStreamPlayer
var extraPlayer: AudioStreamPlayer

var extraAudioActive: bool = false
var extraAudioVolume: float = 0.0

func _ready() -> void:
	mainPlayer = AudioStreamPlayer.new()
	mainPlayer.stream = load("res://LeniaMain.wav")
	add_child(mainPlayer)
	mainPlayer.play()

	extraPlayer = AudioStreamPlayer.new()
	extraPlayer.stream = load("res://LeniaExtra.wav")
	extraPlayer.volume_db = linear2db(0.0)
	add_child(extraPlayer)
	extraPlayer.play()

func _process(delta: float) -> void:
	if extraAudioActive:
		extraAudioVolume += delta * 0.1
	else:
		extraAudioVolume -= delta * 0.1

	extraAudioVolume = clamp(extraAudioVolume, 0.0, 1.0)

	extraPlayer.volume_db = linear2db(extraAudioVolume)
