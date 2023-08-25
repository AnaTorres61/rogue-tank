extends CanvasLayer



func _ready():
	GAME.connect("score_changed", self, "on_score_changed")
#	$score.text = str(GAME.score)


func on_score_changed():
	$score.text = str(GAME.score)
	