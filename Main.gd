extends Node2D

## Seed - 2
# 27
# 45
# 29
# 35
# 0.02

## Seed - 9
# 23.6
# 45
# 29
# 35
# 0.02

### Life!!
## Seed - 9
# 31
# 41
# 32.9
# 31
# 0.1

var frame: int = 0
var active: bool = false

var mouseDown: bool = false
var mouseDownRight: bool = false

func _ready() -> void:
	$Viewport/Reset.show()
	var mat = $Viewport/Sprite.material
	mat.set_shader_param("BactiveSumLeft", Global.activeSumLeft)
	mat.set_shader_param("BactiveSumRight", Global.activeSumRight)
	mat.set_shader_param("BunactiveSumLeft", Global.unactiveSumLeft)
	mat.set_shader_param("BunactiveSumRight", Global.unactiveSumRight)
	mat.set_shader_param("smoothness", Global.smoothness)
	mat.set_shader_param("lerping", Global.lerping)
	$Palette1.visible = Global.palette == 1
	$Palette2.visible = Global.palette == 0
	$Palette3.visible = Global.palette == 2

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			mouseDown = event.button_index == BUTTON_LEFT
			mouseDownRight = event.button_index == BUTTON_RIGHT
		else:
			mouseDown = false
			mouseDownRight = false

	if event is InputEventMouseMotion:
		$Viewport/Light.position = event.position / 4.0
		$Viewport/Dark.position = event.position / 4.0

func createSquare(pos: Vector2, color: float) -> void:
	var square: ColorRect = ColorRect.new()
	square.rect_position = pos
	square.rect_size = Vector2.ONE
	square.color = Color(color, color, color, 1.0)
	$Viewport/Reset.add_child(square)

func _process(_delta: float) -> void:
	frame += 1

	if Input.is_action_just_pressed("pause"):
		active = not active

	if Input.is_action_just_pressed("exit"):
		get_tree().change_scene("res://Setup.tscn")

	$Viewport/Sprite.material.set_shader_param("simulationActivated", (frame % 5 == 0) and active)

	$Viewport/Light.visible = mouseDown
	$Viewport/Dark.visible = mouseDownRight


func _on_Timer_timeout() -> void:
	$Viewport/Reset.hide()
	active = true
	frame = -1
