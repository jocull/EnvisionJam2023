extends Control

func _ready():
	GameManager.connect("earn_score", show_score)

func show_score(newScore: float):
	$score_screen/Score.text = str(newScore)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.phase == GameManager.PHASE.Results:
		$score_screen.visible = true
	else:
		$score_screen.visible = false
	
	if GameManager.phase == GameManager.PHASE.Game:
		$game_screen.visible = true
		$startup_screen.visible = false
		$game_screen/countdown.text = str(ceilf(GameManager.timer))
		$game_screen/countdown.rotation_degrees = -3 + (randf() * 6)
	else:
		$startup_screen/countdown.text = str(ceilf(GameManager.timer))
		$game_screen.visible = false
		$startup_screen.visible = true
		$game_screen/countdown.rotation_degrees = 0
