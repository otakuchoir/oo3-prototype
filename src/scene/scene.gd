class_name Scene extends Node

signal incr_line
signal decr_line

var aps: Array[AnimationPlayer]
var chars: Array[Node]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aps.assign(find_children("", "AnimationPlayer"))
	chars.assign(find_children("", "Character") + find_children("", "Focusable"))
	print("scene chars: ", chars)
	$Stage/DialoguePanel.incr_line.connect(func(): incr_line.emit())
	$Stage/DialoguePanel.decr_line.connect(func(): decr_line.emit())
	#p.update_line(r.current_line())
	print('scene init: '+self.name)

func line_updated(line: DialogueLine) -> void:
	$Stage/DialoguePanel.update_line(line)
	for ap in aps:
		ap.update_line(line)
	for c in chars:
		c.update_line(line)
