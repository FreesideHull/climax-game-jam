extends Control


onready var score_label: Label = $Score
onready var score_lives: Label = $Lives
onready var level_progress: ProgressBar = $ProgressBar
onready var boss_health_bar: ProgressBar = $BossHealth

func _ready():
	PlayerData.connect("score_update", self, "update_interface")
	PlayerData.connect("lives_update", self, "update_interface")
	PlayerData.connect("progress_update", self, "update_progress")
	PlayerData.connect("boss_health_update", self, "update_boss_health")
	
	update_interface()


func update_interface() -> void:
	score_label.text = "Score: %s" % PlayerData.score
	score_lives.text = "Lives: %s" % PlayerData.lives

func update_progress() -> void:
	level_progress.value = PlayerData.levelprogress
	if PlayerData.levelprogress >= 100:
		level_progress.visible = false;
		level_progress.hide();
		boss_health_bar.show();


func update_boss_health() -> void:
	boss_health_bar.value = PlayerData.boss_health
