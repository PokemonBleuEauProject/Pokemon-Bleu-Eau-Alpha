extends ColorRect

onready var player = get_node(PG.ActualScene + "/Player")

var TextEditBool1 = false
var TextEditBool2 = false

func _ready():
	HideEverything()
	self.visible = false
func _input(event):
	if (Input.is_action_just_pressed("ui_cheat_console")) :
		if visible :
			HideEverything()
			get_node(PG.ActualScene + "/GUITotal/CheatConsole").visible = false
			get_tree().paused = false
		else : 
			HideSecondaryThings()
			get_node(PG.ActualScene + "/GUITotal/CheatConsole").visible = true
			get_tree().paused = true

#POSITION :
func _on_Position_pressed():
	$PositionPopup.popup_centered()

func _on_Origine_pressed():
	HideEverything()
	get_tree().paused = false
	player.position = Vector2(0,0)
func _on_Choix_pressed():
	HideSecondaryThings()
	$PositionPopup/ChoixEdit.visible = true
	$PositionPopup/ChoixEdit2.visible = true
	$PositionPopup/ValiderChoix.visible = true
func _on_ChoixEdit_text_changed(new_text):
	if float(new_text) or new_text == "-" : TextEditBool1 = true
	else : 
		TextEditBool1 = false
		$PositionPopup/ChoixEdit.text = "ERROR"
func _on_ChoixEdit2_text_changed(new_text):
	if float(new_text) or new_text == "-" : TextEditBool2 = true
	else : 
		TextEditBool2 = false
		$PositionPopup/ChoixEdit2.text = "ERROR"
func _on_ValiderChoix_pressed():
	if TextEditBool1 and TextEditBool2 :
		player.position = Vector2(float($PositionPopup/ChoixEdit.text),float($PositionPopup/ChoixEdit2.text))
#MAIN
func _on_Scene_pressed():
	HideSecondaryThings()
	$PositionPopup/Scenepopup.popup_centered()
#SECONDARIES
func _on_StartHouse_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/BourgPalette/StartHouse1-Down.tscn")
func _on_LaboChen_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/BourgPalette/LaboChen.tscn")
func _on_PokemonCenterJadielle_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/PokemonCenter/PokemonCenterInside - Jadielle.tscn")
func _on_PokemonCenterArgenta_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/PokemonCenter/PokemonCenterInside - Argenta.tscn")
func _on_ShopJadielle_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/Shop/Shop - Jadielle.tscn")
func _on_ShopArgenta_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/Shop/Shop - Argenta.tscn")
func _on_Musee_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/Argenta/Musee.tscn")
func _on_ForetJade_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/ForetDeJade/ForetDeJade.tscn")

#OTHERS
func HideEverything() :
	$PokemonsPopup.hide()
	$PositionPopup.hide()
	$ObjetsPopup.hide()
	$ArgentPopup.hide()
	HideSecondaryThings()
func HideSecondaryThings() :
	$PositionPopup/ChoixEdit.visible = false
	$PositionPopup/ChoixEdit2.visible = false
	$PositionPopup/ValiderChoix.visible = false
	$PositionPopup/Scenepopup.hide()
