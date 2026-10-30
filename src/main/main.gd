extends Node

var main_menu_cls = preload("res://src/main_menu/main_menu.tscn")
var pause_menu_cls = preload("res://src/pause_menu/pause_menu.tscn")
var start_cls = preload("res://src/show_prototype_onescene.tscn")
var start2_cls = preload("res://src/show_prototype_multiscene.tscn")

var main_menu: MainMenu
var pause_menu: PauseMenu
var scene: Node

enum State { MainMenu, Game, Game2 }
var state: State = State.MainMenu

func _ready() -> void:
	main_menu = main_menu_cls.instantiate()
	pause_menu = pause_menu_cls.instantiate()
	main_menu.start.connect(func(): set_state(State.Game))
	main_menu.start2.connect(func(): set_state(State.Game2))
	pause_menu.quit_to_main_menu.connect(func(): set_state(State.MainMenu))
	self.enter_state(State.MainMenu)

func set_state(st: State) -> void:
	self.exit_state(self.state)
	self.enter_state(st)

func enter_state(st: State) -> void:
	self.state = st
	match st:
		State.MainMenu:
			self.add_child(main_menu)
		State.Game:
			scene = start_cls.instantiate()
			self.add_child(scene)
			# pause must go last, so it renders on top
			self.add_child(pause_menu)
		State.Game2:
			scene = start2_cls.instantiate()
			self.add_child(scene)
			# pause must go last, so it renders on top
			self.add_child(pause_menu)

func exit_state(st: State) -> void:
	match st:
		State.MainMenu:
			self.remove_child(main_menu)
		State.Game:
			self.remove_child(pause_menu)
			self.remove_child(scene)
			scene.queue_free()
		State.Game2:
			self.remove_child(pause_menu)
			self.remove_child(scene)
			scene.queue_free()
