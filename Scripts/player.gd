extends KinematicBody2D
class_name Actor

var velocity = Vector2.ZERO
export var speed =250.0

export var bullet_speed = 1000.0
export var fire_rate = 0.5

export var max_health = 100
export var damaged_rate = 0.5
export var min_health = 0
var health = max_health


var player_bullet_path = preload("res://scenes/Bullet.tscn")

var fire_possible = true
var get_damaged = true
var shoot = AudioStreamPlayer.new()

var first_time = true



		



func _process(_delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("fire") and fire_possible:
		Fire();
		
		if  first_time:
			self.add_child(shoot);
			shoot.stream = load("res://assets/Sound/Shoot.wav")
			first_time = false
			
		shoot.play(true);

	 
func _physics_process(_delta: float) -> void:
	velocity = Move() * speed
	
	move_and_slide(velocity)

func _ready():
	set_health()
	update_health()

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

#func _on_body_touched():
#	print(1)
#	health -= 10
#	if get_damaged == true:
#		update_health()
#	get_damaged = false
#	yield(get_tree().create_timer(damaged_rate), "timeout")
#	get_damaged = true


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




func _on_Shoot_finished():
	shoot.play(false)
