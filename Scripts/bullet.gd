extends RigidBody2D

var Blood_Path = preload("res://scenes/Blood.tscn");

func _on_Bullet_body_entered(body):
	
	if !body.is_in_group("player"):
		queue_free()
		
	if body.is_in_group("Enemy"):
		var Blood = Blood_Path.instance()
		Blood.position = body.get_global_position()
		get_tree().get_root().add_child(Blood)
		body.health-=1
		if body.health == 0 :
			body.queue_free()
		queue_free()
	
