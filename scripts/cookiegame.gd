extends Control

var cookies = 1
var amount_per_click = 2

func _ready() -> void:
	$fade_anim/AnimationPlayer.play("fade_in")
	$fade_anim/AnimationPlayer.animation_finished.connect(_on_fade_finished)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	
	for btn in $VBoxContainer2.get_children():
		btn.set_meta("cost", int(btn.text))
		btn.text = "cost:\n{0}".format([btn.get_meta("cost")])
		
		btn.pressed.connect(func(): _on_upgrade_pressed(btn))
	
	_update_ui()

func _on_fade_finished(_anim_name: StringName) -> void:
	$fade_anim.mouse_filter = ColorRect.MOUSE_FILTER_IGNORE

func _on_cookiebutton_button_down() -> void:
	cookies *= amount_per_click
	_update_ui()

func _on_upgrade_pressed(btn: Button) -> void:
	var cost: int = btn.get_meta("cost")
	if cookies < cost:
		return
	
	cookies -= cost
	btn.queue_free()
	
	_update_ui()

func _update_ui() -> void:
	$VBoxContainer/Label.text = str(cookies) + " cookies"
