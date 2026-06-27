extends StaticBody3D

func interact():
	$fade_anim.show()
	$fade_anim/fade_timer.start()
	$fade_anim/AnimationPlayer.play("Fade_out")
	$"../../CanvasLayer/TextureRect".hide()

func _on_fade_timer_timeout() -> void:
		get_tree().change_scene_to_file("res://scenes/cookie_clicker.tscn")
