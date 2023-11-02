extends AnimatedSprite2D

# 初始速度
var v0:float = 10
# 实时速度
var v:float
# 时间间隔
var t:float = 0.25
# 重力
var g:float = 4
# 运动距离
var s:float = 0
# 倾角
var dip:float

var current_scene

var column1
var column2

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	current_scene = get_tree().get_current_scene()
	column1 = get_node("../../Column1")
#	print(column1)
	column2 = get_node("../../Column2")
#	print(column2)
#	print(current_scene.game_over)
#	print(position.x)
#	print(position.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_scene.game_over_flag:
		return
	if hit_bottom() and !column1.hit(self) and !column2.hit(self):
		fly(delta)
		if column1.get_score(self) or column2.get_score(self):
			current_scene.score += 1
		return
	stop()
	current_scene.game_over()

func hit_bottom() -> bool:
	return position.y <= 150

func init():
	position.x = -77
	position.y = -19
	rotation = 0
	v = v0
	play("fly")

func fly(delta):
	# 垂直的运动距离
	s = v * t - g * t * t / 2
#	print(s)
	# 实时速度，这是物理公式，实时速度等于初始速度-加速度*时间
	v -= g * t
#	print(v)
	if s < 0:
		s = delta * (s * 60)
	position.y -= s
	dip = atan(s / 192)
#	print(rotation)
	rotate(dip)

func step():
	v = v0
	rotation = 0
