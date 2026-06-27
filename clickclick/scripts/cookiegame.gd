extends Control

var cookies = 1
var amount_per_click = 2

func _ready() -> void:
	$fade_anim/AnimationPlayer.play("fade_in")
	$fade_anim/AnimationPlayer.animation_finished.connect(_on_fade_finished)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	_update_ui()

func _on_fade_finished(_anim_name: StringName) -> void:
	$fade_anim.mouse_filter = ColorRect.MOUSE_FILTER_IGNORE

func _on_cookiebutton_button_down() -> void:
	cookies *= amount_per_click
	_update_ui()

func _update_ui() -> void:
	$VBoxContainer/Label.text = str(cookies) + " cookies"

func _on_Upgrade_01_pressed() -> void:
	if cookies >= 10:
		cookies -= 10
		amount_per_click += 1
		$VBoxContainer2/Upgrade_01.queue_free()
		_update_ui()


func _on_upgrade_02_pressed() -> void:
	if cookies >= 100:
		cookies -= 100
		amount_per_click += 8
		$VBoxContainer2/Upgrade_02.queue_free()
		_update_ui()


func _on_upgrade_03_pressed() -> void:
	if cookies >= 200:
		cookies -= 200
		amount_per_click += 15
		$VBoxContainer2/Upgrade_03.queue_free()
		_update_ui()


func _on_upgrade_04_pressed() -> void:
	if cookies >= 500:
		cookies -= 500
		amount_per_click += 75
		$VBoxContainer2/Upgrade_04.queue_free()
		_update_ui()
