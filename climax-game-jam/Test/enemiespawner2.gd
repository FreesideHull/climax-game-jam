extends Node

var timer = 1000.0
var spawn_delay = 1
var can_spawn = true
var enemycount = 0


func _ready():
	var rand = RandomNumberGenerator.new()
	var enemyscene = load("res://climax-game-jam/Test/Enemy.tscn")
	var world = load("res://climax-game-jam/Test/world.tscn")
	var screen_size = get_viewport().get_visible_rect().size
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(spawn_delay)
	timer.connect("timeout", self, "on_timeout_complete")
	add_child(timer)
	
	while (can_spawn == true):
		for i in range(0, 3):
				var enemy = enemyscene.instance()
				var x = rand.randf_range(1280, 1408)
				rand.randomize()
				var y = rand.randf_range(64, 672)
				enemy.position.y =   y
				enemy.position.x =  PlayerData.worldpos + 100 + x
				add_child(enemy)
				can_spawn = false
				timer.start()

func on_timeout_complete():
	timer = 100.0
	## check how many enimes we have
	var en = get_tree().get_nodes_in_group("enemies")
	if len(en) < 5:
		can_spawn = true
		_ready()
	else:
		can_spawn = false
		_ready()
