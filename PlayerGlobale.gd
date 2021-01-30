extends Node

var UnUsed

#Pokemon Of the player
export (Dictionary) var PokemonTypical = {
	Name = null,
	Hp = null,
	MaxHp = null,
	Lvl = null,
	Experience = null,
	ExperienceNeededToLvlUp = null,
	Statut = null,
	Puissance = null,
	AttaqueSpecial = null,
	Defense = null,
	DefenseSpecial = null,
	Vitesse = null,
	Attaque1 = null,
	Attaque2 = null,
	Attaque3 = null,
	Attaque4 = null,
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null,
	TextureOverworld = null
}
export (Dictionary) var Pokemon1 = {
	Name = "Carapuce",
	Hp = 19,
	MaxHp = 19,
	Lvl = 3,
	Experience = 20,
	ExperienceNeededToLvlUp = 30,
	Statut = "",
	Puissance = 48,
	Defense = 65,
	AttaqueSpecial = 50,
	DefenseSpecial = 64,
	Vitesse = 1,
	LvlNeededToEvolve = 16,
	Attaque1 = "Poudre Toxik",
	Attaque2 = "Double Dard",
	Attaque3 = "Crocs Feu",
	Attaque4 = "Choc Mental",
	ActualPPAttaque1 = 20,
	ActualPPAttaque2 = 20,
	ActualPPAttaque3 = 20,
	ActualPPAttaque4 = 20,
	TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/7.png"}
export (Dictionary) var Pokemon2 = {
	Name = "Salameche",
	Lvl = 5,
	Hp = 20,
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
	ActualPPAttaque4 = 20,
	TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/4.png"}
export (Dictionary) var Pokemon3 = {
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
	ActualPPAttaque4 = 20,
	TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/4.png"}
export (Dictionary) var Pokemon4 = null
export (Dictionary) var Pokemon5 = null
export (Dictionary) var Pokemon6 = null
export (Dictionary) var ListPokemon = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6]
#Object of the Player
export (Dictionary) var AllObject = {
	"NumberObject" : {
	#	Number Medicaments
		NumberPotion = 3,
		NumberSuperPotion = 0,
		NumberHyperPotion = 0,
		NumberMaxPotion = 0,
		NumberGuerison = 0,
		NumberRappel = 0,
		NumberRappelMax = 0,
		NumberAntidote = 0,
		NumberAntiPara = 0,
		NumberAntiBrule = 0,
		NumberReveil = 0,
		NumberTotalSoin = 0,
		NumberElixir = 0,
		NumberMaxElixir = 0,
		NumberHuile = 0,
		NumberMaxHuile = 0,
		NumberEau = 0,
		NumberSoda = 0,
		NumberLimonade = 0,
		NumberLait = 0,
	#	Number Pokeball
		NumberPokeball = 5,
		NumberSuperBall = 0,
		NumberHyperBall = 0,
		NumberChronoBall = 0,
		NumberFiletBall = 0,
		NumberFaibloBall = 0,
		NumberMasterBall = 1,
	#	Number Others objects
		NumberCordeDeSortie = 0,
		NumberRepousse = 0,
		NumberSuperRepousse = 0}
}
export (Dictionary) var Badge = {
	BadgeRoche = false,
	BadgeCascade = false,
	BadgeFoudre = false,
	BadgePrisme = false,
	BadgeAme = false,
	BadgeMarais = false,
	BadgeVolcan = false,
	BadgeTerre = false
}
#Others
export (int) var Argent = 154800
export (String) var PlayerName = "No"
export (Dictionary) var GameTime = {
	Minutes = 0,
	Hours = 0,
	Days = 0
}
#Function : Count Pokemon
func CheckNumberOfPokemon() :
	ListPokemon = [Pokemon1,Pokemon2,Pokemon3,Pokemon4,Pokemon5,Pokemon6]
	var NumberOfPokemon = 0
	for x in ListPokemon :
		if (x == null or x.Hp == 0) :
			break
		else :
			NumberOfPokemon = NumberOfPokemon + 1
	return NumberOfPokemon
func GetAPokemonInLife() :
	var PokemonNumber = 0
	for x in ListPokemon :
		if (x != null and x.Hp != 0) :
			return PokemonNumber
		else :
			PokemonNumber = PokemonNumber + 1
	return null
func CheckDictionnaryPokemonFree() :
	var c = 0
	for x in ListPokemon :
		c = c + 1
		if x == null :
			return c

#Global VAr for Player's position
var CantMoveCauseChangingScene
var CantMoveCauseJumping
export (String) var NodePositionPath = "Spawn"
export (Vector2) var Last_position
export (String) var ActualScene
export (String) var ActualPlace = "Bourg Palette"

#GLOBAL VAR FOR SPEED PLAYER
export (bool) var IsShoesEquip = false
#MENU USER VAR
export (bool) var CantdisplayMenu = false
