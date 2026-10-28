extends Node

@export var active_scene: Node:
	set(s):
		if self.active_scene && s != self.active_scene:
			self._set_scene_active(self.active_scene, false)
		active_scene = s
		self._set_scene_active(s, true)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for s in $Scenes.get_children():
		if s != self.active_scene:
			self._set_scene_active(s, false)
	$Scenes.process_mode = Node.PROCESS_MODE_INHERIT
	self.active_scene = self.active_scene

func _set_scene_active(s: Node, enabled: bool) -> void:
	s.process_mode = Node.PROCESS_MODE_INHERIT if enabled else Node.PROCESS_MODE_DISABLED
	s.visible = enabled
