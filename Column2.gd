extends Sprite2D

var distance = 245

var gap = 144

var max 
var min

var current_scene

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
		position.x = 2 * distance - 39
		position.y = min + randi() % (max - min + 1)

func hit(bird : AnimatedSprite2D) -> bool:
#	print(bird.position.x)
#	print(bird.position.y)
	var x1 = position.x - 39 - 28
	var x2 = position.x + 39 + 28
	var y1 = position.y - gap / 2 + 24
	var y2 = position.y + gap / 2 - 24
	if bird.global_position.x >= x1 and bird.global_position.x <= x2:
		if bird.global_position.y <= y1 or bird.global_position.y > y2:
			return true
		else:
			return false
	return false

func init():
	position.x = 468 + distance
	max = 420 - gap / 2
	min = 80 + gap / 2
	position.y = min + randi() % (max - min + 1)
