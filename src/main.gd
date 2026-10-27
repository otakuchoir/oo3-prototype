extends Node

var main_menu_cls = preload("res://res/main_menu.tscn")
var pause_menu_cls = preload("res://res/pause_menu.tscn")
var start_cls = preload("res://res/oo3-prototype.tscn")

var main_menu: MainMenu
var pause_menu: PauseMenu
var scene: Node

enum State { MainMenu, Game }
var state: State = State.MainMenu

func _ready() -> void:
	main_menu = main_menu_cls.instantiate()
	pause_menu = pause_menu_cls.instantiate()
	main_menu.start.connect(func(): set_state(State.Game))
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

func exit_state(st: State) -> void:
	match st:
		State.MainMenu:
			self.remove_child(main_menu)
		State.Game:
			self.remove_child(pause_menu)
			self.remove_child(scene)
			scene.queue_free()
