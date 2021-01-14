extends Popup


func showText(Text) :
	$display.play("display")
	yield(get_tree().create_timer(0.15),"timeout")
	$Label.text = Text
