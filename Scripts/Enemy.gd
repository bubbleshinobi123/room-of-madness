extends KinematicBody2D
export var health = 5.0
export var enemy_speed = 100.0
var enemy_velocity = Vector2.ZERO
var target
#var direction = 1



func _physics_process(delta):
	target = get_parent().get_node_or_null("Player")
	if (target != null):
		var distance = target.global_position - global_position
#		if distance.x < 0:
#			direction = -1
#		else:
#			direction = 1
#		self.scale.x = self.scale.y * direction

		enemy_velocity = distance.normalized()
		enemy_velocity = move_and_slide(enemy_velocity * enemy_speed)
