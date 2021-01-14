extends Area2D

export (String) var NameNotification



func _on_ANotification_body_entered(body):
	get_node(PG.ActualScene + "/GUITotal/Notification").showText(NameNotification)
