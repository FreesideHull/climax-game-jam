extends Control

var scene

func _on_creditsButton_pressed():
	scene = "res://climax-game-jam/Credits/credits.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_StartGameButton_pressed():
	PlayerData.reset()
	scene = "res://climax-game-jam/trans1/trans.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_backButton_pressed():
	scene = "res://climax-game-jam/titlescreen/titlescreen.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_trans1Button_pressed():
	scene = "res://climax-game-jam/Test/world.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_trans2Button_pressed():
	scene = "res://climax-game-jam/Test/world2.tscn"
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_FadeIn_fade_finished():
	get_tree().change_scene(scene)
