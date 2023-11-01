extends Sprite2D

var current_scene
var distance = 117
var _offset = 50
var column
var bird
var first = true

# Called when the node enters the scene tree for the first time.
func _ready():
	current_scene = get_tree().get_current_scene()
	bird = get_node("../Bg/AnimatedBird2D")
	column = get_node("../Column2")
	init()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_scene.game_over_flag:
		return
#	print(str(bird.global_position.x) + " " + str(bird.global_position.y) + " " + str(position.x) + " " + str(position.y))
	if position.x + 22 >= 0:
		if hit():
			hide()
#			print('没撞到')
		else:
#			print('撞到了')
			show()
		move_local_x(-delta * (60), false)
	else:
		position.x = column.position.x + distance
		position.y = column.position.y - 92 + randi() % (184)
	pass

func hit() -> bool:
	var x1 = position.x - 22 - 24
	var y1 = position.y - 22 - 24
	var y2 = position.y + 22 + 24
	if bird.global_position.x >= x1:
#		print(str(bird.global_position.x) + " " + str(bird.global_position.y) + "     " + str(position.x) + " " + str(position.y))
		if first:
			if bird.global_position.y >= y1 and bird.global_position.y <= y2:
				first = false
				return true
			else:
				return false
		else:
			return true
	else:
		first = true
	return false

func init():
	position.x = column.position.x + distance
	position.y = column.position.y - 92 + randi() % (184)
#	print(position.y)
#	position.y = 80 + randi() % (144)
#	print(position.y)
	
