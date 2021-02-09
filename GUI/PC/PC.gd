extends Control

var displayStats = false
var displayDetails = false
var disabledetails = false
var ThePokemonFocused

#ALL POKEMON PC DICTIONNARY
var Pokemon1 = null
var Pokemon2 = null
var Pokemon3 = null
var Pokemon4 = null
var Pokemon5 = null
var Pokemon6 = null
var Pokemon7 = null
var Pokemon8 = null
var Pokemon9 = null
var Pokemon10 = null
var Pokemon11 = null
var Pokemon12 = null
var Pokemon13 = null
var Pokemon14 = null
var Pokemon15 = null
var Pokemon16 = null
var Pokemon17 = null
var Pokemon18 = null
var Pokemon19 = null
var Pokemon20 = null
var Pokemon21 = null
var Pokemon22 = null
var Pokemon23 = null
var Pokemon24 = null
var Pokemon25 = null
var Pokemon26 = null
var Pokemon27 = null
var Pokemon28 = null
var Pokemon29 = null
var Pokemon30 = null
var Pokemon31 = null
var Pokemon32 = null
var Pokemon33 = null
var Pokemon34 = null
var Pokemon35 = null
var Pokemon36 = null
var Pokemon37 = null
var Pokemon38 = null
var Pokemon39 = null
var Pokemon40 = null
var Pokemon41 = null
var Pokemon42 = null
var Pokemon43 = null
var Pokemon44 = null
var Pokemon45 = null
var Pokemon46 = null
var Pokemon47 = null
var Pokemon48 = null
var Pokemon49 = null
var Pokemon50 = null
var Pokemon51 = null
var Pokemon52 = null
var Pokemon53 = null
var Pokemon54 = null
var Pokemon55 = null
var Pokemon56 = null
var Pokemon57 = null
var Pokemon58 = null
var Pokemon59 = null
var Pokemon60 = null

func _ready():
	pass

func _input(event):
	if event is InputEventMouseButton:
		var focused = get_focus_owner()
		if focused is ButtonPokemonPC :
			IdentificationFocus(focused)
			LoadAllParameterFocus()

func IdentificationFocus(focused) :
	var path = str(focused.get_path())
	var pathParent = str(focused.get_parent().get_path())
	if pathParent == "/root/PC/VosPokemons" :
		match focused.DictionnaryToLoad :
			"PG.Pokemon1" : ThePokemonFocused = PG.Pokemon1
			"PG.Pokemon2" : ThePokemonFocused = PG.Pokemon2
			"PG.Pokemon3" : ThePokemonFocused = PG.Pokemon3
			"PG.Pokemon4" : ThePokemonFocused = PG.Pokemon4
			"PG.Pokemon5" : ThePokemonFocused = PG.Pokemon5
			"PG.Pokemon6" : ThePokemonFocused = PG.Pokemon6
	else :
		match focused.DictionnaryToLoad :
			"PC.Pokemon1" : ThePokemonFocused = Pokemon1
			"PC.Pokemon2" : ThePokemonFocused = Pokemon2
			"PC.Pokemon3" : ThePokemonFocused = Pokemon3
			"PC.Pokemon4" : ThePokemonFocused = Pokemon4
			"PC.Pokemon5" : ThePokemonFocused = Pokemon5
			"PC.Pokemon6" : ThePokemonFocused = Pokemon6
			"PC.Pokemon7" : ThePokemonFocused = Pokemon7
			"PC.Pokemon8" : ThePokemonFocused = Pokemon8
			"PC.Pokemon9" : ThePokemonFocused = Pokemon9
			"PC.Pokemon10" : ThePokemonFocused = Pokemon10
			"PC.Pokemon11" : ThePokemonFocused = Pokemon11
			"PC.Pokemon12" : ThePokemonFocused = Pokemon12
			"PC.Pokemon13" : ThePokemonFocused = Pokemon13
			"PC.Pokemon14" : ThePokemonFocused = Pokemon14
			"PC.Pokemon15" : ThePokemonFocused = Pokemon15
			"PC.Pokemon16" : ThePokemonFocused = Pokemon16
			"PC.Pokemon17" : ThePokemonFocused = Pokemon17
			"PC.Pokemon18" : ThePokemonFocused = Pokemon18
			"PC.Pokemon19" : ThePokemonFocused = Pokemon19
			"PC.Pokemon20" : ThePokemonFocused = Pokemon20
			"PC.Pokemon21" : ThePokemonFocused = Pokemon21
			"PC.Pokemon22" : ThePokemonFocused = Pokemon22
			"PC.Pokemon23" : ThePokemonFocused = Pokemon23
			"PC.Pokemon24" : ThePokemonFocused = Pokemon24
			"PC.Pokemon25" : ThePokemonFocused = Pokemon25
			"PC.Pokemon26" : ThePokemonFocused = Pokemon26
			"PC.Pokemon27" : ThePokemonFocused = Pokemon27
			"PC.Pokemon28" : ThePokemonFocused = Pokemon28
			"PC.Pokemon29" : ThePokemonFocused = Pokemon29
			"PC.Pokemon30" : ThePokemonFocused = Pokemon30
			"PC.Pokemon31" : ThePokemonFocused = Pokemon31
			"PC.Pokemon32" : ThePokemonFocused = Pokemon32
			"PC.Pokemon33" : ThePokemonFocused = Pokemon33
			"PC.Pokemon34" : ThePokemonFocused = Pokemon34
			"PC.Pokemon35" : ThePokemonFocused = Pokemon35
			"PC.Pokemon36" : ThePokemonFocused = Pokemon36
			"PC.Pokemon37" : ThePokemonFocused = Pokemon37
			"PC.Pokemon38" : ThePokemonFocused = Pokemon38
			"PC.Pokemon39" : ThePokemonFocused = Pokemon39
			"PC.Pokemon40" : ThePokemonFocused = Pokemon40
			"PC.Pokemon41" : ThePokemonFocused = Pokemon41
			"PC.Pokemon42" : ThePokemonFocused = Pokemon42
			"PC.Pokemon43" : ThePokemonFocused = Pokemon43
			"PC.Pokemon44" : ThePokemonFocused = Pokemon44
			"PC.Pokemon45" : ThePokemonFocused = Pokemon45
			"PC.Pokemon46" : ThePokemonFocused = Pokemon46
			"PC.Pokemon47" : ThePokemonFocused = Pokemon47
			"PC.Pokemon48" : ThePokemonFocused = Pokemon48
			"PC.Pokemon49" : ThePokemonFocused = Pokemon49
			"PC.Pokemon50" : ThePokemonFocused = Pokemon50
			"PC.Pokemon51" : ThePokemonFocused = Pokemon51
			"PC.Pokemon52" : ThePokemonFocused = Pokemon52
			"PC.Pokemon53" : ThePokemonFocused = Pokemon53
			"PC.Pokemon54" : ThePokemonFocused = Pokemon54
			"PC.Pokemon55" : ThePokemonFocused = Pokemon55
			"PC.Pokemon56" : ThePokemonFocused = Pokemon56
			"PC.Pokemon57" : ThePokemonFocused = Pokemon57
			"PC.Pokemon58" : ThePokemonFocused = Pokemon58
			"PC.Pokemon59" : ThePokemonFocused = Pokemon59
			"PC.Pokemon60" : ThePokemonFocused = Pokemon60

func LoadAllParameterFocus() :
	if ThePokemonFocused == null : disabledetails = true
	else :
		disabledetails = false
		$PC/Graphic/ImageInfo/PokemonImage.texture = load(ThePokemonFocused.TextureFight)

#UI BUTTON FOR EXITING, DISPLAY AND OTHERS
func _on_Details_pressed():
	if disabledetails : pass
	elif !displayDetails and !disabledetails : 
		displayDetails = true
		$Donnee.popup()
func _on_Stats_pressed():
	if !displayStats : 
		displayStats = true
		$Stats.popup()
	else : 
		displayStats = false
		$Stats.hide()
func _on_LeaveDetails_pressed():
	displayDetails = false
	$Donnee.hide()
func _on_OutsideButton_pressed():
	self.visible = false
