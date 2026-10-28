class_name MainMenu extends Control

signal start
signal start2

@onready var buttons: Node = $VBoxContainer/VBoxContainer
@onready var start_button: LinkButton = buttons.get_node('StartButton')
@onready var start_button2: LinkButton = buttons.get_node('StartButton2')

func _ready() -> void:
	start_button.pressed.connect(func(): start.emit())
	start_button2.pressed.connect(func(): start2.emit())
