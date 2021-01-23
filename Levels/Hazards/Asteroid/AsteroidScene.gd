extends RigidBody2D

class_name Asteroid

signal collision

var report: bool = true

func _ready():
	connect("body_entered", self, "body_entered")

func body_entered(body):
	var result = Physics2DTestMotionResult.new()
	if test_motion(Vector2(0,0), true, 0.08, result):
		emit_signal("collision", result)
