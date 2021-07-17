extends Control

var settings_file = "user://settings.save"
var sounds_volume = -10
var music_volume = -10
var fullscreen = false

func _ready():
	load_settings()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music_volume)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), sounds_volume)
	$OptionsPanel/MusicVolume.value = music_volume
	$OptionsPanel/SoundsVolume.value = sounds_volume
	$OptionsPanel/FullscreenCheck.pressed = fullscreen

func save_settings():
	var player_settings = File.new()
	player_settings.open(settings_file, File.WRITE)
	player_settings.store_var(fullscreen)
	player_settings.close()

func load_settings():
	var player_settings = File.new()
	if player_settings.file_exists(settings_file):
		player_settings.open(settings_file, File.READ)
		fullscreen = player_settings.get_var()

func _on_PlayButton_pressed():
	if !$SelectSound.is_playing():
		$SelectSound.play()
	get_tree().change_scene("res://scenes/level.tscn")


func _on_OptionsButton_pressed():
	if !$SelectSound.is_playing():
		$SelectSound.play()
	$MainMenuPanel.visible = false
	$OptionsPanel.visible = true


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_BackButton_pressed():
	if !$SelectSound.is_playing():
		$SelectSound.play()
	$MainMenuPanel.visible = true
	$OptionsPanel.visible = false


func _on_MusicVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	music_volume = value
	save_settings()


func _on_SoundsVolume_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sounds"), value)
	sounds_volume = value
	save_settings()

func _on_FullscreenCheck_toggled(button_pressed):
	if !$SelectSound.is_playing():
		$SelectSound.play()
	fullscreen = button_pressed
	OS.window_fullscreen = !OS.window_fullscreen
	save_settings()
