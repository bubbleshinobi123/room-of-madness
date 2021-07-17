extends Control

onready var health_bar = $HealthBar

func on_health_updated(health):
	health_bar.value = health
	
func _on_max_health_updated(max_health):
	health_bar.max_value = max_health

func set_min_health(min_health):
	health_bar.min_value = min_health
