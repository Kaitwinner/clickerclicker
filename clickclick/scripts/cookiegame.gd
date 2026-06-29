extends Control

var cookies = 1
var amount_per_click = 2

func _ready() -> void:
	$fade_anim/AnimationPlayer.play("fade_in")
	$fade_anim/AnimationPlayer.animation_finished.connect(_on_fade_finished)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	for upgrade_name in UPGRADES:
		var btn = $VBoxContainer2.get_node(upgrade_name)
		btn.pressed.connect(_on_upgrade_pressed.bind(upgrade_name))
	_update_ui()

func _on_fade_finished(_anim_name: StringName) -> void:
	$fade_anim.mouse_filter = ColorRect.MOUSE_FILTER_IGNORE

func _on_cookiebutton_button_down() -> void:
	cookies += amount_per_click
	_update_ui()

func _update_ui() -> void:
	$VBoxContainer/Label.text = str(cookies) + " cookies"

const UPGRADES = {
	"Upgrade_01": {"cost": 50,  "bonus": 1},
	"Upgrade_02": {"cost": 200, "bonus": 2},
	"Upgrade_03": {"cost": 200, "bonus": 2},
	"Upgrade_04": {"cost": 1500, "bonus": 15},
}

func _on_upgrade_pressed(upgrade_name: String) -> void:
	var upgrade = UPGRADES[upgrade_name]
	if cookies >= upgrade.cost:
		cookies -= upgrade.cost
		amount_per_click += upgrade.bonus
		$VBoxContainer2.get_node(upgrade_name).queue_free()
		_update_ui()
