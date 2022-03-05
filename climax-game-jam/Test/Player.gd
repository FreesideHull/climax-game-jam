extends KinematicBody2D

const FIREBALL = preload("res://climax-game-jam/Test/Fireball.tscn")

var speed = 200
var yspeed = 500
var facing_right = true
var velocity = Vector2()
var distanceTraveled = 0;

func _ready():
	pass # Replace with function body.

var collided = false;

var can_shoot = true;

const map_length = 50;


var isBossFight = false;
var bossPossition: Vector2;

func DistanceTraveled():
	if isBossFight:
		return
	var pos = $Sprite.get_global_transform().origin.x / 100;
	distanceTraveled = pos / map_length * 100
	PlayerData.levelprogress = distanceTraveled;
	if distanceTraveled >= 100:
		isBossFight = true;	
		bossPossition = $Sprite.get_global_transform().origin;

		
func _physics_process(delta):
	PlayerData.worldpos = $Sprite.get_global_transform().origin.x
	DistanceTraveled()
	get_input()
	velocity = move_and_slide(velocity)

	
	if !collided:
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision != null && collision.collider != null && "Enemy" in collision.collider.name:
				collided = true;
				can_shoot = false;
				PlayerData.lives -= 1
				$CollisionShape2D.disabled = true;
				if PlayerData.lives <= 0:
					get_tree().change_scene("res://climax-game-jam/GameOverScreen/GameOverScreen.tscn")
				else:
					$Sprite.modulate = Color(1, 1, 1, 0.5)
					yield(get_tree().create_timer(0.5),"timeout")
					$Sprite.modulate = Color(1, 1, 1, 1)
					yield(get_tree().create_timer(0.5),"timeout")
					$Sprite.modulate = Color(1, 1, 1, 0.5)
					yield(get_tree().create_timer(0.5),"timeout")
					$Sprite.modulate = Color(1, 1, 1, 1)
					$CollisionShape2D.disabled = false;
					collided = false;
					can_shoot = true;

func get_input():
	velocity = Vector2()
	if facing_right == true:
		$Sprite.scale.x = 0.045
		$Sprite.scale.y = 0.045
	else:
		$Sprite.scale.x = 0.045
		$Sprite.scale.y = 0.045
	if PlayerData.lives <= 0:
		get_tree().change_scene("res://climax-game-jam/GameOverScreen/GameOvercreen.tscn")
	if Input.is_action_pressed("menu"):
		PlayerData.lives = 3
		get_tree().change_scene("res://climax-game-jam/TitleScreen/TitleScreen.tscn")
	
	if Input.is_action_pressed("up"):
		velocity.y -= Input.get_action_strength("up") * yspeed
		$AnimationPlayer.play("Run")
	elif Input.is_action_pressed("down"):
		#velocity.y += 1
		velocity.y += Input.get_action_strength("down") * yspeed
		$AnimationPlayer.play("Run")
	else:
		$AnimationPlayer.play("Idle")
	
	if Input.is_action_just_pressed("fire") && can_shoot:
		var fireball = FIREBALL.instance()
		get_parent().add_child(fireball)
		fireball.position = $FireballOrigin.global_position

	if !isBossFight:
		velocity.x += 1 * speed
	else:
		var pos = $Sprite.get_global_transform().origin;
		if Input.is_action_pressed("right") && pos.x < bossPossition.x + 500:
			velocity.x += Input.get_action_strength("right") * speed
			$AnimationPlayer.play("Run")
			facing_right = true;
		elif Input.is_action_pressed("left") && pos.x > bossPossition.x - 500:
			velocity.x -= Input.get_action_strength("left") * speed
			$AnimationPlayer.play("Run")
			facing_right = false;
			
		

	
	#velocity = velocity.normalized() * speed
