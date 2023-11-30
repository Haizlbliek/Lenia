extends Control

var modulateColor: float = 0.0

func _ready() -> void:
	$Settings/HSlider.value = Global.seedValue
	$Settings/Presets.get_child(Global.preset).pressed = true
	$Settings/HSlider.editable = Global.preset == 3 and not Global.seedRandomized
	$Settings/CheckButton.pressed = Global.seedRandomized
	$Settings/Palette.get_child(Global.palette).pressed = true
	loadPalette()
	$CanvasModulate.color.r = modulateColor
	$CanvasModulate.color.g = modulateColor
	$CanvasModulate.color.b = modulateColor
	$Settings/Lerping.pressed = Global.lerping
	$Settings/Lerping.disabled = Global.preset != 3

func _process(delta: float) -> void:
	modulateColor += delta
	modulateColor = clamp(modulateColor, 0.0, 1.0)
	$CanvasModulate.color.r = modulateColor
	$CanvasModulate.color.g = modulateColor
	$CanvasModulate.color.b = modulateColor

func loadPalette() -> void:
	if Global.palette == 0:
		$Main/Title.material = load("res://palettes/Palette0Title.tres")
	elif Global.palette == 1:
		$Main/Title.material = load("res://palettes/Palette1Title.tres")
	else:
		$Main/Title.material = null

func _on_Start_pressed() -> void:
	if Global.preset != 3:
		var preset = Global.presets[Global.preset]
		Global.activeSumLeft = preset[0]
		Global.activeSumRight = preset[1]
		Global.unactiveSumLeft = preset[2]
		Global.unactiveSumRight = preset[3]
		Global.smoothness = preset[4]
		Global.seedRandomized = false

	get_tree().change_scene("res://Main.tscn")

func _on_HSlider_value_changed(value: float) -> void:
	$Settings/Label.text = "Seed: " + str(value)
	Global.seedValue = int(value)

func _on_CheckButton_toggled(button_pressed: bool) -> void:
	$Settings/HSlider.editable = not button_pressed

	Global.seedRandomized = button_pressed

	if button_pressed:
		$Settings/Label.text = "Seed: Random"
	else:
		$Settings/Label.text = "Seed: " + str($Settings/HSlider.value)

func _on_BackToMain_pressed() -> void:
	$Main.show()
	$Settings.hide()
	$Controls.hide()
	loadPalette()
	Global.extraAudioActive = false

func _on_Settings_pressed() -> void:
	$Main.hide()
	$Settings.show()
	Global.extraAudioActive = true

func _on_Quit_pressed() -> void:
	get_tree().quit()

func _on_Group0_toggled(button_pressed: bool) -> void:
	if button_pressed:
		$Settings/HSlider.editable = false
		$Settings/HSlider.value = Global.presets[0][5]
		Global.preset = 0
		Global.lerping = false
		$Settings/Lerping.pressed = false
		$Settings/Lerping.disabled = true

func _on_Group1_toggled(button_pressed: bool) -> void:
	if button_pressed:
		$Settings/HSlider.editable = false
		$Settings/HSlider.value = Global.presets[1][5]
		Global.preset = 1
		Global.lerping = false
		$Settings/Lerping.pressed = false
		$Settings/Lerping.disabled = true

func _on_Group2_toggled(button_pressed: bool) -> void:
	if button_pressed:
		$Settings/HSlider.editable = false
		$Settings/HSlider.value = Global.presets[2][5]
		Global.preset = 2
		Global.lerping = false
		$Settings/Lerping.pressed = false
		$Settings/Lerping.disabled = true

func _on_Group3_toggled(button_pressed: bool) -> void:
	if button_pressed:
		$Settings/HSlider.editable = true
		$Settings/Lerping.disabled = false
		Global.preset = 3

func _on_Palette0_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.palette = 0

func _on_Palette1_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.palette = 1


func _on_Palette2_toggled(button_pressed: bool) -> void:
	if button_pressed:
		Global.palette = 2


func _on_Controls_pressed() -> void:
	$Main.hide()
	$Controls.show()


func _on_Lerping_toggled(button_pressed: bool) -> void:
	Global.lerping = button_pressed
