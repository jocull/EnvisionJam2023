extends Control

func _ready():
	GameManager.connect("earn_score", show_score)
	GameManager.connect("enter_phase", phase_change)

func show_score(newScore: float):
	$score_screen/Score.text = str(newScore)

func phase_change(newPhase: GameManager.PHASE):
	match newPhase:
		GameManager.PHASE.Startup:
			$startup_screen.visible = true
			$game_screen.visible = false
			$score_screen.visible = false
		GameManager.PHASE.Game:
			$startup_screen.visible = false
			$game_screen.visible = true
			$score_screen.visible = false
		GameManager.PHASE.Results:
			$startup_screen.visible = true
			$game_screen.visible = false
			$score_screen.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match GameManager.phase:
		GameManager.PHASE.Game:
			$game_screen/countdown.text = str(ceilf(GameManager.timer))
			# Font scale
			var remaining: float = ceilf(GameManager.timer)
			var intensityRatio = 1 - ((remaining / 15.0) * 0.85)
			$game_screen/countdown.set("theme_override_font_sizes/font_size", intensityRatio * 512)
			# Shake
			$game_screen/countdown.position.x = intensityRatio * (-16 + (randf() * 32))
			$game_screen/countdown.position.y = intensityRatio * (-16 + (randf() * 32))
		_: # else
			$startup_screen/countdown.text = "Get ready: " + str(ceilf(GameManager.timer))
