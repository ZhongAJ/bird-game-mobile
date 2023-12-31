extends Sprite2D

var distance = 235

var gap = 144

var max 
var min

var current_scene
var through = false

# Called when the node enters the scene tree for the first time.
func _ready():
	current_scene = get_tree().get_current_scene()
	init()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_scene.game_over_flag:
		return
	if position.x + 39 >= 0:
		move_local_x(-delta * (60), false)
	else:
		position.x = 2 * distance
		position.y = min + randi() % (max - min + 1)

func hit(bird : AnimatedSprite2D) -> bool:
	var x1 = position.x - 39 - 28
	var x2 = position.x + 39 + 28
	var y1 = position.y - gap / 2 + 24
	var y2 = position.y + gap / 2 - 24
	
	if bird.global_position.x >= x1 and bird.global_position.x <= x2:
		if bird.global_position.y <= y1 or bird.global_position.y > y2:
			print(str(bird.global_position.x) + ' ' + str(bird.global_position.y))
			print(str(x1) + ' ' + str(y1))
			print(str(x2) + ' ' + str(y2))
			return true
		else:
			return false
	return false

func init():
	position.x = 468
	max = 420 - gap / 2
	min = 80 + gap / 2
	position.y = min + randi() % (max - min + 1)

func get_score(bird : AnimatedSprite2D) -> bool:
	if bird.global_position.x >= position.x + 39:
		if !through:
			if bird.global_position.y > position.y - (gap / 2) + 24 and bird.global_position.y < position.y + (gap / 2) - 24:
				through = true
				return true
			else:
				return false
		else:
			return false
	else:
		through = false
	return false
