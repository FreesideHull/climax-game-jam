extends Control


var scene

func _on_creditsButton_pressed():
	scene = "res://climax-game-jam/Credits/credits.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_StartGameButton_pressed():
	scene = "res://climax-game-jam/test/world.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_backButton_pressed():
	scene = "res://climax-game-jam/titlescreen/titlescreen.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	PlayerData.reset()
	get_tree().change_scene(scene)
