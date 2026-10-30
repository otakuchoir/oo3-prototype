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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for s in $Scenes.get_children():
		self._set_scene_active(s, false)
	$Scenes.process_mode = Node.PROCESS_MODE_INHERIT
	self.active_scene_name = self.active_scene_name

func _set_scene_active(s: Node, enabled: bool) -> void:
	print('set scene active: ', s, enabled, 'visible' in s)
	s.process_mode = Node.PROCESS_MODE_INHERIT if enabled else Node.PROCESS_MODE_DISABLED
	s.visible = enabled
