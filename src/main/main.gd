extends Node

var main_menu_cls = preload("res://src/main_menu/main_menu.tscn")
var pause_menu_cls = preload("res://src/pause_menu/pause_menu.tscn")
var prototype_onescene_cls = preload("res://scenes_prototype/show_prototype_onescene.tscn")
var prototype_multiscene_cls = preload("res://scenes_prototype/show_prototype_multiscene.tscn")

var main_menu: MainMenu
var pause_menu: PauseMenu
var scene: Node

enum State { MainMenu, ShowPrototypeOneScene, ShowPrototypeMultiScene }
var state: State = State.MainMenu

func _ready() -> void:
	main_menu = main_menu_cls.instantiate()
	pause_menu = pause_menu_cls.instantiate()
	main_menu.start.connect(func(): set_state(State.ShowPrototypeOneScene))
	main_menu.start2.connect(func(): set_state(State.ShowPrototypeMultiScene))
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
		State.ShowPrototypeOneScene:
			scene = prototype_onescene_cls.instantiate()
			scene.end_dialogue.connect(func(): set_state(State.MainMenu))
			self.add_child(scene)
			# pause must go last, so it renders on top
			self.add_child(pause_menu)
		State.ShowPrototypeMultiScene:
			scene = prototype_multiscene_cls.instantiate()
			scene.end_dialogue.connect(func(): set_state(State.MainMenu))
			self.add_child(scene)
			# pause must go last, so it renders on top
			self.add_child(pause_menu)

func exit_state(st: State) -> void:
	match st:
		State.MainMenu:
			self.remove_child(main_menu)
		State.ShowPrototypeOneScene:
			self.remove_child(pause_menu)
			self.remove_child(scene)
			scene.queue_free()
		State.ShowPrototypeMultiScene:
			self.remove_child(pause_menu)
			self.remove_child(scene)
			scene.queue_free()
