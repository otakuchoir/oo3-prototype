class_name PauseMenu extends Control

signal quit_to_main_menu

@onready var buttons: Node = $Menu/VBoxContainer/VBoxContainer
@onready var resume_button: LinkButton = buttons.get_node('ResumeButton')
@onready var quit_button: LinkButton = buttons.get_node('QuitButton')

func _ready() -> void:
	hide()
	# without process_mode=always, the pause menu itself will be frozen too.
	# this must also apply to the VIEWPORT the pause menu's rendered in, or you'll see that same symptom!
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	resume_button.pressed.connect(func(): toggle_pause())
	quit_button.pressed.connect(func(): set_pause(false); quit_to_main_menu.emit())

func _input(event: InputEvent) -> void:
	#print('input', event)
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func set_pause(val: bool) -> void:
	print('set_pause %s' % val)
	self.visible = val
	get_tree().paused = val

func toggle_pause() -> void:
	self.set_pause(!get_tree().paused)
