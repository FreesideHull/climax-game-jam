extends KinematicBody2D

const speed = 1
var velocity = Vector2()

var is_dead = false
var scene
var health = 100;

func _ready():
	pass
	
func hit():
	PlayerData.boss_health -= 10
	PlayerData.score += 10
	if PlayerData.boss_health <= 0:
		dead();
		
func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	scene = "res://climax-game-jam/trans-final/trans.tscn"
	get_tree().change_scene(scene)

func _on_Timer_timeout():
	queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_VisibilityNotifier2D_viewport_entered(viewport):
	pass # Replace with function body.
