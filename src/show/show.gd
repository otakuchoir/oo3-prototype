extends Node

var active_scene: Node
@export var active_scene_name: String:
	set(n):
		if !self.is_node_ready():
			active_scene_name = n
			return
		var s = $Scenes.get_node(n)
		assert(s, "no such scene name: "+n)
		if self.active_scene && s != self.active_scene:
			self._set_scene_active(self.active_scene, false)
		active_scene_name = n
		self.active_scene = s
		self._set_scene_active(s, true)

var aps: Array[AnimationPlayer]

signal end_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	aps.assign(find_children("", "AnimationPlayer"))
	for s in $Scenes.get_children():
		self._set_scene_active(s, false)
	$Scenes.process_mode = Node.PROCESS_MODE_INHERIT
	self.active_scene_name = self.active_scene_name
	$DialogueReader.line_updated.connect(_line_updated)
	$DialogueReader.end_dialogue.connect(func(): end_dialogue.emit())

func _line_updated(line: DialogueLine) -> void:
		for ap in aps:
			ap.update_line(line)

func _set_scene_active(s: Scene, enabled: bool) -> void:
	print('set scene active: ', s, enabled, 'visible' in s)
	s.process_mode = Node.PROCESS_MODE_INHERIT if enabled else Node.PROCESS_MODE_DISABLED
	s.visible = enabled
	s.incr_line.connect($DialogueReader.incr_line)
	s.decr_line.connect($DialogueReader.decr_line)
	$DialogueReader.line_updated.connect(s.line_updated)
	s.line_updated($DialogueReader.current_line())
