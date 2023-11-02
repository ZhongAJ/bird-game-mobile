extends Node2D

static var game_over_flag:bool = true
static var ready_flag:bool = true
static var score = 0

var ground_x

# Called when the node enters the scene tree for the first time.
func _ready():
#	Engine.max_fps = 30
	$Bg/AnimatedBird2D.play("fly")
	$Gameover.hide()
	$Ground.move_to_front()
	$Gameover.move_to_front()
	$Start.move_to_front()
	ground_x = $Ground.position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(score)
	$RichTextLabel.text = "分数：" + str(score)
	$Ground.move_local_x(-delta * (60 * 2), false)
	if $Ground.position.x <= 40:
		$Ground.position.x = ground_x

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		if game_over_flag:
			if ready_flag:
				ready_flag = false
				game_over_flag = false
				$Start.hide()
			else:
				ready_flag = true
				$Start.show()
				$Gameover.hide()
			score = 0
			$Bg/AnimatedBird2D.init()
			$Column1.init()
			$Column2.init()
			$Money1.init()
			$Money2.init()
		else:
			$Bg/AnimatedBird2D.step()

func game_over():
	$Gameover.show()
	game_over_flag = true
