extends Node

var start_cls = preload("res://res/oo3-prototype.tscn")
var menu_cls = preload("res://res/main_menu.tscn")

func _ready() -> void:
	var menu: MainMenu = menu_cls.instantiate()
	var scene: Node
	self.add_child(menu)
	menu.start_button.pressed.connect(func():
		scene = start_cls.instantiate()
		self.add_child(scene)
		self.remove_child(menu)
		)
