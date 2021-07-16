extends KinematicBody2D
class_name Actor

var velocity = Vector2.ZERO;
export var speed =200.0;

func _process(delta: float) -> void:
	look_at(get_global_mouse_position());
	
	 
func _physics_process(delta: float) -> void:
	velocity = Move() * speed;
	
	move_and_slide(velocity);



func Move() -> Vector2:
	var direction = Vector2(
		 Input.get_action_strength("move_right") - Input.get_action_strength("move_left") ,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up") 
	);
	return direction;
