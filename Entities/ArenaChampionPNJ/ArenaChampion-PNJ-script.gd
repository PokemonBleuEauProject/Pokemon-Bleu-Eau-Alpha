#     LINEAR PNJ : EXAMPLE

extends KinematicBody2D

signal loadPlayerParametre

export (String) var TXTIntro
export (String) var EnnemiName
export (Texture) var TheTexture
export (Texture) var TheInFightTexture
export (String) var Badge
export (String) var TXT1
export (String) var TXT2
export (String) var TXT3

onready var player = get_node(PG.ActualScene + "/Player")
onready var animationFight
onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")


export (Dictionary) var POKEMON1 = {
	Name = "Salameche",
	Lvl = 5,
	Hp = 25,
	MaxHp = 25,
	Puissance = 48,
	Defense = 65,
	AttaqueSpecial = 50,
	DefenseSpecial = 64,
	Vitesse = 60,
	Experience = 0,
	LvlNeededToEvolve = 16,
	ExperienceNeededToLvlUp = 30,
	Statut = "",
	Type1 = "Feu",
	Type2 = "-",
	Attaque1 = "Griffe",
	Attaque2 = "Rugissement",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20}
export (Dictionary) var POKEMON2
export (Dictionary) var POKEMON3
export (Dictionary) var POKEMON4
export (Dictionary) var POKEMON5
export (Dictionary) var POKEMON6

func _ready():
	if TheTexture != null : $Sprite.texture = TheTexture
	animationFight = get_node(PG.ActualScene + "/GUITotal/Fight")


func talk() :
	if TXT2 == "" :
		UISpeack.ListOfTxt = [TXT1]
	elif TXT3 == "" :
		UISpeack.ListOfTxt = [TXT1,TXT2]
	else :
		UISpeack.ListOfTxt = [TXT1,TXT2,TXT3]
	UISpeackScene.display()
	yield(UISpeackScene.get_node("Show_Text"),"animation_finished")
	loadParameters()
	UIFight.TxtIntro = TXTIntro
	UIFight.TypeOfFight = "FightDresseur"
	animationFight.play("LaunchingFight")
	PG.ActualScene = "/root/FightScene"
	yield(animationFight,"animation_finished")
	PG.UnUsed = get_tree().change_scene("res://Fight/FightScene.tscn")

func loadParameters() :
#	Texture and Graphic
	EG.TextureFight = TheInFightTexture
	UIFight.CercleFight = load("res://img Pokemon/img Fight/Graphique/CercleFightWhite.png")
	UIFight.BGCOLOR = Color(1, 1, 1)
#	Pokemon
	EG.Pokemon1 = POKEMON1
	EG.Pokemon2 = POKEMON2
	EG.Pokemon3 = POKEMON3
	EG.Pokemon4 = POKEMON4
	EG.Pokemon5 = POKEMON5
	EG.Pokemon6 = POKEMON6
#	Information
	EG.EnnemiName = EnnemiName
