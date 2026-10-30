extends Node

@export var dialogue_reader: DialogueReader
signal quit_to_main_menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var r = dialogue_reader
	var p = $Stage/DialoguePanel
	p.incr_line.connect(r.incr_line)
	p.decr_line.connect(r.decr_line)
	r.line_updated.connect(p.update_line)
	r.end_dialogue.connect(quit_to_main_menu.emit)
	p.update_line(r.current_line())
	print('scene init: '+self.name)
