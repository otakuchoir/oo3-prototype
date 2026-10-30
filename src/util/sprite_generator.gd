@tool extends EditorScript

func _run() -> void:
	#var t = " "+str(Time.get_unix_time_from_system())
	var t = ""
	var d = 'res://assets/oo2/Character Sprites/'
	generate("Usagi"+t, d, 'usagi-', 'usagi-postgrad-')
	generate("Usagi Postgrad"+t, d, 'usagi-postgrad-')
	generate("Takeshi"+t, d, 'takeshi-', 'takeshi-postgrad-')
	generate("Takeshi Postgrad"+t, d, 'takeshi-postgrad-')
	generate("Sanders"+t, d, 'sanders-', 'sanders-postgrad-')
	generate("Sanders Postgrad"+t, d, 'sanders-postgrad-')
	
func filename_predicate(f: String, prefix: String, unprefix: String):
	return f.begins_with(prefix) \
		and not f.begins_with(unprefix) \
		and f.ends_with('.png') \
		and true
func animation_name_from_filename(f: String, prefix: String):
	return f.split(prefix)[1].split('.png')[0]

func generate(name: String, dirname: String,  prefix: String, unprefix: String="__UNUSED_UNPREFIX"):
	var anim = SpriteFrames.new()
	var dim = Vector2(0, 0)
	for filename in DirAccess.get_files_at(dirname):
		if filename_predicate(filename, prefix, unprefix):
			#print(filename)
			var animname = animation_name_from_filename(filename, prefix)
			anim.add_animation(animname)
			var img = load(dirname+filename)
			anim.add_frame(animname, img)
			dim = img.get_size() # we assume all frames are the same dimensions
	anim.remove_animation("default")
	ResourceSaver.save(anim, "res://res/"+name+".tres")
	
	var root = EditorInterface.get_edited_scene_root()
	var node = Node2D.new()
	node.name = name
	root.add_child(node)
	node.owner = root
	
	var sprite = AnimatedSprite2D.new()
	
	sprite.sprite_frames = anim
	sprite.name = "AnimatedSprite2D"
	sprite.centered = true
	sprite.offset = Vector2(0, dim[1] / -2.0)
	node.add_child(sprite)
	sprite.owner = root
