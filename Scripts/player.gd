extends KinematicBody2D
class_name Actor

var velocity = Vector2.ZERO
export var speed =250.0
export var bullet_speed = 1000.0
export var fire_rate = 0.5

var player_bullet_path = preload("res://scenes/Bullet.tscn")

var fire_possible = true

func _process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and fire_possible:
		Fire();
	 
func _physics_process(delta: float) -> void:
	velocity = Move() * speed
	
	move_and_slide(velocity)



func Move() -> Vector2:
	var direction = Vector2(
		 Input.get_action_strength("move_right") - Input.get_action_strength("move_left") ,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up") 
	)
	return direction
	
	
func Fire() -> void:
		var bullet = player_bullet_path.instance()
		bullet.position = $BulletPoint.get_global_position()
		bullet.rotation_degrees = rotation_degrees
		bullet.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet)
		fire_possible = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		fire_possible = true
