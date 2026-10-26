class_name MainMenu extends Control

signal start

@onready var buttons: Node = $VBoxContainer/VBoxContainer
@onready var start_button: LinkButton = buttons.get_node('StartButton')

func _ready() -> void:
	start_button.pressed.connect(func(): start.emit())
