extends Node

var main_menu_cls = preload("res://res/main_menu.tscn")
var pause_menu_cls = preload("res://res/pause_menu.tscn")
var start_cls = preload("res://res/oo3-prototype.tscn")

var main_menu: MainMenu
var pause_menu: PauseMenu
var scene: Node

func _ready() -> void:
	main_menu = main_menu_cls.instantiate()
	pause_menu = pause_menu_cls.instantiate()
	self.add_child(main_menu)
	main_menu.start.connect(start)
	pause_menu.quit_to_main_menu.connect(quit_to_main_menu)

func start() -> void:
	self.remove_child(main_menu)
	
	scene = start_cls.instantiate()
	self.add_child(scene)
	# pause must go last, so it renders on top
	self.add_child(pause_menu)

func quit_to_main_menu() -> void:
	self.remove_child(pause_menu)
	self.remove_child(scene)
	self.add_child(main_menu)
