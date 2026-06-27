extends Node2D

var ButtonType = null

func _on_start_pressed() -> void:
	ButtonType = "Start"
	$fade_anim.show()
	$fade_anim/fade_timer.start()
	$fade_anim/AnimationPlayer.play("Fade_out")

func _on_options_pressed() -> void:
	ButtonType = "Options"
	$fade_anim.show()
	$fade_anim/fade_timer.start()
	$fade_anim/AnimationPlayer.play("Fade_out")

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_fade_timer_timeout() -> void:
	if ButtonType == "Start":
		get_tree().change_scene_to_file("res://scenes/world_1.tscn")
	elif ButtonType == "Options":
		get_tree().change_scene_to_file("aa")
