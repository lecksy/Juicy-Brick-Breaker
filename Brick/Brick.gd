extends StaticBody2D

var score = 0
var new_position = Vector2.ZERO
var dying = false

var powerup_prob = 0.1

func _ready():
	randomize()
	position = new_position
	if score == 100:
		$ColorRect.color = Color8(26,25,24)
	elif score == 90:
		$ColorRect.color = Color8(56,89,198)
	elif score == 80:
		$ColorRect.color = Color8(52,162,209)
	elif score == 70:
		$ColorRect.color = Color8(88,178,43)
	elif score == 60:
		$ColorRect.color = Color8(166,230,134)
	elif score == 50:
		$ColorRect.color = Color8(255,224,196)
	elif score == 40:
		$ColorRect.color = Color8(255,210,27)
	elif score == 30:
		$ColorRect.color = Color8(255,255,255)

func _physics_process(_delta):
	if dying:
		queue_free()

func hit(_ball):
	die()

func die():
	dying = true
	collision_layer = 0
	$ColorRect.hide()
	Global.update_score(score)
	if not Global.feverish:
		Global.update_fever(score)
	get_parent().check_level()
	if randf() < powerup_prob:
		var Powerup_Container = get_node_or_null("/root/Game/Powerup_Container")
		if Powerup_Container != null:
			var Powerup = load("res://Powerups/Powerup.tscn")
			var powerup = Powerup.instantiate()
			powerup.position = position
			Powerup_Container.call_deferred("add_child", powerup)
