extends KinematicBody2D
export var max_health = 5
export var enemy_speed = 100.0
export var min_health = -1
var enemy_velocity = Vector2.ZERO
var target
#var direction = 1

var health = max_health

func _physics_process(_delta):
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
		
func _ready():
	set_health()
	update_health()
	
func set_health():
	for child in get_children():
		if child.has_method("_on_max_health_updated"):
			child._on_max_health_updated(max_health)
	for child in get_children():
		if child.has_method("set_min_health"):
			child.set_min_health(min_health)
func update_health():
	for child in get_children():
		if child.has_method("on_health_updated"):
			child.on_health_updated(health)
