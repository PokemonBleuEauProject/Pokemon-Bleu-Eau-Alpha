extends Control

var displayStats = false
var displayDetails = false
var disableDetails = false
var ThePokemonFocused = null
var ThePokemonSelected = null
var ChangeActivated = false

func _ready():
	ThePokemonFocused = null
	disableDetails = true
	$Graphic/Modifier.visible = false
	LoadAllImages()

func _input(event):
	if event is InputEventMouseButton:
		var focused = get_focus_owner()
		if focused is ButtonPokemonPC :
			searchPokemonDictionnary(focused.DictionnaryToLoad)
			if ThePokemonFocused != null : $Graphic/Modifier.visible = true
			else : $Graphic/Modifier.visible = false
			LoadAllParameterFocus()
	elif Input.is_action_just_pressed("ui_accept") :
		ThePokemonSelected = ThePokemonFocused
#Graphic and Stats informations
func LoadAllParameterFocus() :
	if ThePokemonFocused == null : 
		disableDetails = true
		UnLoad()
	else :
		disableDetails = false
		$Graphic/ImageInfo/PokemonImage.texture = Pokemon.GetImageFront(ThePokemonFocused.Name)
		$Donnee/Numero.text = str(Pokemon.GetNumberPokedex(ThePokemonFocused.Name))
		$Donnee/Name.text = ThePokemonFocused.Name
		if ThePokemonFocused.Type1 == null : $Donnee/Type1.texture = null
		else : $Donnee/Type1.texture = Pokemon.GetImageType(ThePokemonFocused.Type1)
		if ThePokemonFocused.Type2 == null : $Donnee/Type2.texture = null
		else : $Donnee/Type2.texture = Pokemon.GetImageType(ThePokemonFocused.Type2)
		$Donnee/HpLabel.text = str(ThePokemonFocused.Hp) + "/" + str(ThePokemonFocused.MaxHp)
		$Donnee/Hp.value = ThePokemonFocused.Hp
		$Donnee/Hp.max_value = ThePokemonFocused.MaxHp
		$Donnee/LvlLabel.text = "NV. " + str(ThePokemonFocused.Lvl)
		$Donnee/Lvl.value = ThePokemonFocused.Experience
		$Donnee/Lvl.max_value = ThePokemonFocused.ExperienceNeededToLvlUp
		$Donnee/TypeAttaque1.texture = Pokemon.GetImageType(Attaque.GetAttaqueType(ThePokemonFocused.Attaque1))
		$Donnee/Attaque1.text = ThePokemonFocused.Attaque1
		$Donnee/Attaque1PP.text = str(ThePokemonFocused.ActualPPAttaque1) + "/" + str(Attaque.GetAttaqueMaxPP(ThePokemonFocused.Attaque1))
		$Donnee/TypeAttaque2.texture = Pokemon.GetImageType(Attaque.GetAttaqueType(ThePokemonFocused.Attaque2))
		$Donnee/Attaque2.text = ThePokemonFocused.Attaque2
		$Donnee/Attaque2PP.text = str(ThePokemonFocused.ActualPPAttaque2) + "/" + str(Attaque.GetAttaqueMaxPP(ThePokemonFocused.Attaque2))
		$Donnee/TypeAttaque3.texture = Pokemon.GetImageType(Attaque.GetAttaqueType(ThePokemonFocused.Attaque3))
		$Donnee/Attaque3.text = ThePokemonFocused.Attaque3
		$Donnee/Attaque3PP.text = str(ThePokemonFocused.ActualPPAttaque3) + "/" + str(Attaque.GetAttaqueMaxPP(ThePokemonFocused.Attaque3))
		$Donnee/TypeAttaque4.texture = Pokemon.GetImageType(Attaque.GetAttaqueType(ThePokemonFocused.Attaque4))
		$Donnee/Attaque4.text = ThePokemonFocused.Attaque4
		$Donnee/Attaque4PP.text = str(ThePokemonFocused.ActualPPAttaque1) + "/" + str(Attaque.GetAttaqueMaxPP(ThePokemonFocused.Attaque4))
		$Stats/AttaqueSpecial.text = str(ThePokemonFocused.AttaqueSpecial)
		$Stats/DefenseSpecial.text = str(ThePokemonFocused.DefenseSpecial)
		$Stats/Puissance.text = str(ThePokemonFocused.Puissance)
		$Stats/Defense.text = str(ThePokemonFocused.Defense)
		$Stats/Vitesse.text = str(ThePokemonFocused.Vitesse)
func LoadAllImages() :
	var allImage = get_tree().get_nodes_in_group("VosPokemons")
	for pokemon in allImage :
		searchPokemonDictionnary(pokemon.get_parent().DictionnaryToLoad)
		if ThePokemonFocused == null : pokemon.texture = null
		else : pokemon.texture = Pokemon.GetImageOverworld(ThePokemonFocused.Name)
	var PokemonNumberNode = 0
	var PokemonNode = ""
	for x in range(1,16) :
		for y in range(1,5) :
			PokemonNumberNode = PokemonNumberNode + 1
			PokemonNode = get_node("/root/PC-GUI/AllPokemon/VBoxContainer/"+str(x)+"/Pokemon"+str(PokemonNumberNode)+"/Image")
			searchPokemonDictionnary(PokemonNode.DictionnaryToLoad)
			if ThePokemonFocused == null : 
				PokemonNode.texture_normal = null
				PokemonNode.get_parent().get_node("Lvl").text = ""
				PokemonNode.get_parent().get_node("Name").text = ""
			else : 
				PokemonNode.texture_normal = Pokemon.GetImageFront(ThePokemonFocused.Name)
				PokemonNode.get_parent().get_node("Lvl").text = "NV. "+str(ThePokemonFocused.Lvl)
				PokemonNode.get_parent().get_node("Name").text = ThePokemonFocused.Name
	ThePokemonFocused = null
func searchPokemonDictionnary(Name) :
	match Name :
		"PG.Pokemon1" : ThePokemonFocused = PG.Pokemon1
		"PG.Pokemon2" : ThePokemonFocused = PG.Pokemon2
		"PG.Pokemon3" : ThePokemonFocused = PG.Pokemon3
		"PG.Pokemon4" : ThePokemonFocused = PG.Pokemon4
		"PG.Pokemon5" : ThePokemonFocused = PG.Pokemon5
		"PG.Pokemon6" : ThePokemonFocused = PG.Pokemon6
		"PC.Pokemon1" : ThePokemonFocused = PSS.Pokemon1
		"PC.Pokemon2" : ThePokemonFocused = PSS.Pokemon2
		"PC.Pokemon3" : ThePokemonFocused = PSS.Pokemon3
		"PC.Pokemon4" : ThePokemonFocused = PSS.Pokemon4
		"PC.Pokemon5" : ThePokemonFocused = PSS.Pokemon5
		"PC.Pokemon6" : ThePokemonFocused = PSS.Pokemon6
		"PC.Pokemon7" : ThePokemonFocused = PSS.Pokemon7
		"PC.Pokemon8" : ThePokemonFocused = PSS.Pokemon8
		"PC.Pokemon9" : ThePokemonFocused = PSS.Pokemon9
		"PC.Pokemon10" : ThePokemonFocused = PSS.Pokemon10
		"PC.Pokemon11" : ThePokemonFocused = PSS.Pokemon11
		"PC.Pokemon12" : ThePokemonFocused = PSS.Pokemon12
		"PC.Pokemon13" : ThePokemonFocused = PSS.Pokemon13
		"PC.Pokemon14" : ThePokemonFocused = PSS.Pokemon14
		"PC.Pokemon15" : ThePokemonFocused = PSS.Pokemon15
		"PC.Pokemon16" : ThePokemonFocused = PSS.Pokemon16
		"PC.Pokemon17" : ThePokemonFocused = PSS.Pokemon17
		"PC.Pokemon18" : ThePokemonFocused = PSS.Pokemon18
		"PC.Pokemon19" : ThePokemonFocused = PSS.Pokemon19
		"PC.Pokemon20" : ThePokemonFocused = PSS.Pokemon20
		"PC.Pokemon21" : ThePokemonFocused = PSS.Pokemon21
		"PC.Pokemon22" : ThePokemonFocused = PSS.Pokemon22
		"PC.Pokemon23" : ThePokemonFocused = PSS.Pokemon23
		"PC.Pokemon24" : ThePokemonFocused = PSS.Pokemon24
		"PC.Pokemon25" : ThePokemonFocused = PSS.Pokemon25
		"PC.Pokemon26" : ThePokemonFocused = PSS.Pokemon26
		"PC.Pokemon27" : ThePokemonFocused = PSS.Pokemon27
		"PC.Pokemon28" : ThePokemonFocused = PSS.Pokemon28
		"PC.Pokemon29" : ThePokemonFocused = PSS.Pokemon29
		"PC.Pokemon30" : ThePokemonFocused = PSS.Pokemon30
		"PC.Pokemon31" : ThePokemonFocused = PSS.Pokemon31
		"PC.Pokemon32" : ThePokemonFocused = PSS.Pokemon32
		"PC.Pokemon33" : ThePokemonFocused = PSS.Pokemon33
		"PC.Pokemon34" : ThePokemonFocused = PSS.Pokemon34
		"PC.Pokemon35" : ThePokemonFocused = PSS.Pokemon35
		"PC.Pokemon36" : ThePokemonFocused = PSS.Pokemon36
		"PC.Pokemon37" : ThePokemonFocused = PSS.Pokemon37
		"PC.Pokemon38" : ThePokemonFocused = PSS.Pokemon38
		"PC.Pokemon39" : ThePokemonFocused = PSS.Pokemon39
		"PC.Pokemon40" : ThePokemonFocused = PSS.Pokemon40
		"PC.Pokemon41" : ThePokemonFocused = PSS.Pokemon41
		"PC.Pokemon42" : ThePokemonFocused = PSS.Pokemon42
		"PC.Pokemon43" : ThePokemonFocused = PSS.Pokemon43
		"PC.Pokemon44" : ThePokemonFocused = PSS.Pokemon44
		"PC.Pokemon45" : ThePokemonFocused = PSS.Pokemon45
		"PC.Pokemon46" : ThePokemonFocused = PSS.Pokemon46
		"PC.Pokemon47" : ThePokemonFocused = PSS.Pokemon47
		"PC.Pokemon48" : ThePokemonFocused = PSS.Pokemon48
		"PC.Pokemon49" : ThePokemonFocused = PSS.Pokemon49
		"PC.Pokemon50" : ThePokemonFocused = PSS.Pokemon50
		"PC.Pokemon51" : ThePokemonFocused = PSS.Pokemon51
		"PC.Pokemon52" : ThePokemonFocused = PSS.Pokemon52
		"PC.Pokemon53" : ThePokemonFocused = PSS.Pokemon53
		"PC.Pokemon54" : ThePokemonFocused = PSS.Pokemon54
		"PC.Pokemon55" : ThePokemonFocused = PSS.Pokemon55
		"PC.Pokemon56" : ThePokemonFocused = PSS.Pokemon56
		"PC.Pokemon57" : ThePokemonFocused = PSS.Pokemon57
		"PC.Pokemon58" : ThePokemonFocused = PSS.Pokemon58
		"PC.Pokemon59" : ThePokemonFocused = PSS.Pokemon59
		"PC.Pokemon60" : ThePokemonFocused = PSS.Pokemon60
func UnLoad() :
	$Graphic/ImageInfo/PokemonImage.texture = null

#UI BUTTON FOR EXITING, DISPLAY AND OTHERS
func _on_Details_pressed():
	if disableDetails : pass
	elif !displayDetails and !disableDetails : 
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
func _on_Modifier_pressed():
	ChangeActivated = true
	ThePokemonSelected = ThePokemonFocused
