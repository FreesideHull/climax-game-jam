extends Control


onready var score_label: Label = $Score


func _ready():
	PlayerData.connect("score_update", self, "update_interface")
	PlayerData.lives = 3
	score_label.text = "Score: %s" % PlayerData.score
