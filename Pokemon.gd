extends Node

#Health
func health(ThePokemon) :
	ThePokemon.Hp = ThePokemon.MaxHp
	ThePokemon.ActualPPAttaque1 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque1)
	ThePokemon.ActualPPAttaque2 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque2)
	ThePokemon.ActualPPAttaque3 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque3)
	ThePokemon.ActualPPAttaque4 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque4)
	ThePokemon.Statut = ""
func restorePP(ThePokemon):
	ThePokemon.ActualPPAttaque1 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque1)
	ThePokemon.ActualPPAttaque2 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque2)
	ThePokemon.ActualPPAttaque3 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque3)
	ThePokemon.ActualPPAttaque4 = Attaque.GetAttaqueMaxPP(ThePokemon.Attaque4)
#Experiences
func CalculLvlToLvlUp(ThePokemon,Lvl) :
	ThePokemon.ExperienceNeededToLvlUp = 0.5 * pow(Lvl,3)
func CheckLvlUp(ThePokemon,ExpWin) :
	CalculLvlToLvlUp(ThePokemon,ThePokemon.Lvl)
	if ExpWin+ThePokemon.Experience >= ThePokemon.ExperienceNeededToLvlUp :
		ThePokemon.Lvl = ThePokemon.Lvl + 1
		ThePokemon.Experience = (ThePokemon.Experience + ExpWin) - ThePokemon.ExperienceNeededToLvlUp
		CalculLvlToLvlUp(ThePokemon,ThePokemon.Lvl)
	else :
		ThePokemon.Experience += ExpWin
func CheckExpWin(ThePokemon) :
	return (ThePokemon.Lvl/7) *  ThePokemon.BaseLvl
#Ressources about pokemons
func GetNumberPokedex(Name) :
	match Name :
		"Bulbizarre" : return 1
		"Herbizarre" : return 2
		"Florizarre" : return 3
		"Salameche" : return 4
		"Reptincel" : return 5
		"Dracaufeu" : return 6
		"Carapuce" : return 7
		"Carabaffe" : return 8
		"Tortank" : return 9
		"Chenipan" : return 10
		"Chrysacier" : return 11
		"Papilusion" : return 12
		"Aspicot" : return 13
		"Coconfort" : return 14
		"Dardagnan" : return 15
		"Roucool" : return 16
		"Roucoups" : return 17
		"Roucarnage" : return 18
		"Rattata" : return 19
		"Rattatac" : return 20
		"Rayquaza" : return 384
#Images
func GetImageFront(Name) : if Name != null : return load("res://img Pokemon/All Pokemon/Front/"+str(GetNumberPokedex(Name))+".png")
func GetImageBack(Name) : if Name != null : return load("res://img Pokemon/All Pokemon/back/"+str(GetNumberPokedex(Name))+".png")
func GetImageOverworld(Name) : if Name != null : return load("res://img Pokemon/All Pokemon/Overworld/"+str(GetNumberPokedex(Name))+".png")
func GetImageType(Type) : if Type != null : return load("res://img Pokemon/All Type/"+str(Type)+".png")

# All Pokemon in order with all informations -> extends into PlayerPokemon and EnnemiPokemon
#1
class Bulbizarre :
#Important Information
	var Name : String = "Bulbizarre"
	var Prop = null
	var Lvl : int = 3
#Stat Information
#	Life
	var Hp : int = 19
	var MaxHp : int = 19
#Attaque
	var Puissance : int = 49
	var Defense : int = 49
	var AttaqueSpecial : int = 65
	var DefenseSpecial : int = 65
	var Vitesse : int = 45
#	Others
	var Experience : int = 0
	var LvlNeededToEvolve : int = 16
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 64
	var Statut : String = ""
	var CatchRate : int = 45
#	Attaque Information
	var Attaque1 : String = "Griffe"
	var Attaque2 : String = "Rugissement"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
#Type of the Pokemon
	var Type1 : String = "Plante"
	var Type2 : String = "Poison"
#Textures
	var TextureFront = "res://img Pokemon/All Pokemon/Front/1.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/1.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/1.png"
#2
class Herbizarre :
	var Name : String = "Herbizarre"
	var Prop = null
	var Lvl : int = 16
	var Hp : int = 45
	var MaxHp : int = 45
	var Puissance : int = 62
	var Defense : int = 63
	var AttaqueSpecial : int = 80
	var DefenseSpecial : int = 80
	var Vitesse : int = 60
	var Experience : int = 0
	var LvlNeededToEvolve : int = 32
	var ExperienceNeededToLvlUp : int = 3900
	var BaseLvl : int = 141
	var Statut : String = ""
	var CatchRate : int = 35
	var Attaque1 : String = "Belier"
	var Attaque2 : String = "Tranch'Herbe"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Plante"
	var Type2 : String = "Poison"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/2.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/2.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/2.png"
#3
class Florizarre :
	var Name : String = "Florizarre"
	var Prop = null
	var Lvl : int = 32
	var Hp : int = 93
	var MaxHp : int = 93
	var Puissance : int = 82
	var Defense : int = 83
	var AttaqueSpecial : int = 100
	var DefenseSpecial : int = 100
	var Vitesse : int = 80
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 28000
	var BaseLvl : int = 208
	var Statut : String = ""
	var CatchRate : int = 20
	var Attaque1 : String = "Damoclès"
	var Attaque2 : String = "Tanch'Herbe"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Plante"
	var Type2 : String = "Poison"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/3.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/3.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/3.png"
#4
class Salameche :
	var Name : String = "Salameche"
	var Prop = null
	var Lvl : int = 3
	var Hp : int = 16
	var MaxHp : int = 16
	var Puissance : int = 52
	var Defense : int = 43
	var AttaqueSpecial : int = 60
	var DefenseSpecial : int = 50
	var Vitesse : int = 65
	var Experience : int = 0
	var LvlNeededToEvolve : int = 16
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 65
	var Statut : String = ""
	var CatchRate : int = 45
	var Attaque1 : String = "Griffe"
	var Attaque2 : String = "Rugissement"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Feu"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/4.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/4.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/4.png"
#5
class Reptincel :
	var Name : String = "Reptincel"
	var Prop = null
	var Lvl : int = 16
	var Hp : int = 45
	var MaxHp : int = 45
	var Puissance : int = 64
	var Defense : int = 58
	var AttaqueSpecial : int = 80
	var DefenseSpecial : int = 65
	var Vitesse : int = 80
	var Experience : int = 0
	var LvlNeededToEvolve : int = 32
	var ExperienceNeededToLvlUp : int = 3900
	var BaseLvl : int = 143
	var Statut : String = ""
	var CatchRate : int = 35
	var Attaque1 : String = "Flammeche"
	var Attaque2 : String = "Draco Rage"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Feu"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/5.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/5.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/5.png"
#6
class Dracaufeu :
	var Name : String = "Dracaufeu"
	var Prop = null
	var Lvl : int = 32
	var Hp : int = 92
	var MaxHp : int = 92
	var Puissance : int = 84
	var Defense : int = 78
	var AttaqueSpecial : int = 109
	var DefenseSpecial : int = 85
	var Vitesse : int = 100
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 28000
	var BaseLvl : int = 209
	var Statut : String = ""
	var CatchRate : int = 20
	var Attaque1 : String = "Crocs Feu"
	var Attaque2 : String = "Rebondifeu"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Feu"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/6.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/6.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/6.png"
#7
class Carapuce :
	var Name : String = "Carapuce"
	var Prop = null
	var Lvl : int = 3
	var Hp : int = 19
	var MaxHp : int = 19
	var Puissance : int = 48
	var Defense : int = 65
	var AttaqueSpecial : int = 50
	var DefenseSpecial : int = 64
	var Vitesse : int = 60
	var Experience : int = 0
	var LvlNeededToEvolve : int = 16
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 66
	var Statut : String = ""
	var CatchRate : int = 45
	var Type1 : String = "Eau"
	var Type2 : String = "-"
	var Attaque1 : String = "Charge"
	var Attaque2 : String = "Mimi Queue"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var TextureFront = "res://img Pokemon/All Pokemon/Front/7.png"
	var TextureBack = "res://img Pokemon/All Pokemon/back/7.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/7.png"
#8
class Carabaffe :
	var Name : String = "Carabaffe"
	var Prop = null
	var Lvl : int = 16
	var Hp : int = 45
	var MaxHp : int = 45
	var Puissance : int = 63
	var Defense : int = 80
	var AttaqueSpecial : int = 65
	var DefenseSpecial : int = 80
	var Vitesse : int = 58
	var Experience : int = 0
	var LvlNeededToEvolve : int = 32
	var ExperienceNeededToLvlUp : int = 3900
	var BaseLvl : int = 143
	var Statut : String = ""
	var CatchRate : int = 35
	var Attaque1 : String = "Ecume"
	var Attaque2 : String = "Morsure"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Eau"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/8.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/8.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/8.png"
#9
class Tortank :
	var Name : String = "Tortank"
	var Prop = null
	var Lvl : int = 32
	var Hp : int = 92
	var MaxHp : int = 92
	var Puissance : int = 83
	var Defense : int = 100
	var AttaqueSpecial : int = 85
	var DefenseSpecial : int = 108
	var Vitesse : int = 78
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 28000
	var BaseLvl : int = 210
	var Statut : String = ""
	var CatchRate : int = 20
	var Attaque1 : String = "Vribraqua"
	var Attaque2 : String = "Hydroqueue"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Eau"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/9.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/9.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/9.png"
#10
class Chenipan :
	var Name : String = "Chenipan"
	var Prop = null
	var Lvl : int = 3
	var Hp : int = 16
	var MaxHp : int = 16
	var Puissance : int = 30
	var Defense : int = 35
	var AttaqueSpecial : int = 20
	var DefenseSpecial : int = 20
	var Vitesse : int = 45
	var Experience : int = 0
	var LvlNeededToEvolve : int = 7
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 53
	var Statut : String = ""
	var CatchRate : int = 255
	var Attaque1 : String = "Charge"
	var Attaque2 : String = "Secretion"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Insecte"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/10.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/10.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/10.png"
#11
class Chrysacier :
	var Name : String = "Chrysacier"
	var Prop = null
	var Lvl : int = 7
	var Hp : int = 28
	var MaxHp : int = 28
	var Puissance : int = 20
	var Defense : int = 55
	var AttaqueSpecial : int = 25
	var DefenseSpecial : int = 25
	var Vitesse : int = 30
	var Experience : int = 0
	var LvlNeededToEvolve : int = 10
	var ExperienceNeededToLvlUp : int = 400
	var BaseLvl : int = 72
	var Statut : String = ""
	var CatchRate : int = 120
	var Attaque1 : String = "Armure"
	var Attaque2 : String = "Charge"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Insecte"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/11.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/11.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/11.png"
#12
class Papilusion :
	var Name : String = "Papilusion"
	var Prop = null
	var Lvl : int = 10
	var Hp : int = 32
	var MaxHp : int = 32
	var Puissance : int = 45
	var Defense : int = 50
	var AttaqueSpecial : int = 90
	var DefenseSpecial : int = 80
	var Vitesse : int = 70
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 1064
	var BaseLvl : int = 160
	var Statut : String = ""
	var CatchRate : int = 45
	var Attaque1 : String = "Tornade"
	var Attaque2 : String = "Choc Mental"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Insecte"
	var Type2 : String = "Vol"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/12.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/12.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/12.png"
#13
class Aspicot :
	var Name : String = "Aspicot"
	var Prop = null
	var Lvl : int = 3
	var Hp : int = 15
	var MaxHp : int = 15
	var Puissance : int = 35
	var Defense : int = 30
	var AttaqueSpecial : int = 20
	var DefenseSpecial : int = 20
	var Vitesse : int = 50
	var Experience : int = 0
	var LvlNeededToEvolve : int = 7
	var ExperienceNeededToLvlUp : int = 400
	var BaseLvl : int = 52
	var Statut : String = ""
	var CatchRate : int = 255
	var Attaque1 : String = "Dard Venin"
	var Attaque2 : String = "Secretion"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Insecte"
	var Type2 : String = "Poison"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/13.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/13.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/13.png"
#14
class Coconfort :
	var Name : String = "Coconfort"
	var Prop = null
	var Lvl : int = 7
	var Hp : int = 23
	var MaxHp : int = 23
	var Puissance : int = 25
	var Defense : int = 50
	var AttaqueSpecial : int = 25
	var DefenseSpecial : int = 25
	var Vitesse : int = 35
	var Experience : int = 0
	var LvlNeededToEvolve : int = 10
	var ExperienceNeededToLvlUp : int = 1000
	var BaseLvl : int = 71
	var Statut : String = ""
	var CatchRate : int = 120
	var Attaque1 : String = "Armure"
	var Attaque2 : String = "Secretion"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Insecte"
	var Type2 : String = "Poison"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/14.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/14.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/14.png"
#15
class Dardagnan :
	var Name : String = "Dardagnan"
	var Prop = null
	var Lvl : int = 10
	var Hp : int = 35
	var MaxHp : int = 35
	var Puissance : int = 90
	var Defense : int = 40
	var AttaqueSpecial : int = 45
	var DefenseSpecial : int = 80
	var Vitesse : int = 75
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 159
	var Statut : String = ""
	var CatchRate : int = 45
	var Attaque1 : String = "Double Dard"
	var Attaque2 : String = "Furie"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Insecte"
	var Type2 : String = "Poison"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/15.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/15.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/15.png"
#16
class Roucool :
	var Name : String = "Roucool"
	var Prop = null
	var Lvl : int = 3
	var Hp : int = 15
	var MaxHp : int = 15
	var Puissance : int = 45
	var Defense : int = 40
	var AttaqueSpecial : int = 35
	var DefenseSpecial : int = 35
	var Vitesse : int = 56
	var Experience : int = 0
	var LvlNeededToEvolve : int = 18
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 55
	var Statut : String = ""
	var CatchRate : int = 255
	var Attaque1 : String = "Charge"
	var Attaque2 : String = "Jet de sable"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Normal"
	var Type2 : String = "Vol"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/16.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/16.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/16.png"
#17
class Roucoups :
	var Name : String = "Roucoups"
	var Prop = null
	var Lvl : int = 18
	var Hp : int = 50
	var MaxHp : int = 50
	var Puissance : int = 60
	var Defense : int = 55
	var AttaqueSpecial : int = 50
	var DefenseSpecial : int = 50
	var Vitesse : int = 71
	var Experience : int = 0
	var LvlNeededToEvolve : int = 36
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 113
	var Statut : String = ""
	var CatchRate : int = 120
	var Attaque1 : String = "Vive Attaque"
	var Attaque2 : String = "Jet de sable"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Normal"
	var Type2 : String = "Vol"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/17.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/17.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/17.png"
#18
class Roucarnage :
	var Name : String = "Roucarnage"
	var Prop = null
	var Lvl : int = 36
	var Hp : int = 106
	var MaxHp : int = 106
	var Puissance : int = 80
	var Defense : int = 75
	var AttaqueSpecial : int = 70
	var DefenseSpecial : int = 70
	var Vitesse : int = 101
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 172
	var Statut : String = ""
	var CatchRate : int = 45
	var Attaque1 : String = "CruAile"
	var Attaque2 : String = "Cyclone"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Normal"
	var Type2 : String = "Vol"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/18.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/18.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/18.png"
#19
class Rattata :
	var Name : String = "Rattata"
	var Prop = null
	var Lvl : int = 3
	var Hp : int = 15
	var MaxHp : int = 15
	var Puissance : int = 56
	var Defense : int = 35
	var AttaqueSpecial : int = 25
	var DefenseSpecial : int = 35
	var Vitesse : int = 72
	var Experience : int = 0
	var LvlNeededToEvolve : int = 20
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 57
	var Statut : String = ""
	var CatchRate : int = 255
	var Attaque1 : String = "Charge"
	var Attaque2 : String = "Mimi Queue"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Normal"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/19.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/19.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/19.png"
#20
class Rattatac :
	var Name : String = "Rattatac"
	var Prop = null
	var Lvl : int = 20
	var Hp : int = 31
	var MaxHp : int = 31
	var Puissance : int = 81
	var Defense : int = 60
	var AttaqueSpecial : int = 50
	var DefenseSpecial : int = 70
	var Vitesse : int = 97
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 20
	var BaseLvl : int = 116
	var Statut : String = ""
	var CatchRate : int = 127
	var Attaque1 : String = "Vive Attaque"
	var Attaque2 : String = "Puissance"
	var Attaque3 : String = "-"
	var Attaque4 : String = "-"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
	var Type1 : String = "Normal"
	var Type2 : String = "-"
	var TextureFront = "res://img Pokemon/All Pokemon/Front/20.png"
	var TextureBack = "res://img Pokemon/All Pokemon/Back/20.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/20.png"

class Piafabec :
	var Name : String = "Piafabec"

class Rapasdepic :
	var Name : String = "Rapasdepic"

class Abo :
	var Name : String = "Abo"

class Arbok :
	var Name : String = "Arbok"

class Pikachu :
	var Name : String = "Pikachu"

class Raichu :
	var Name : String = "Raichu"

class Sabelette :
	var Name : String = "Sabelette"

class Sablaireau :
	var Name : String = "Sablaireau"

class NidoranF :
	var Name : String = "Nidoran"

class Nidorina :
	var Name : String = "Nidorina"

class Nidoqueen :
	var Name : String = "Nidoqueen"

class NidoranM :
	var Name : String = "Nidoran"

class Nidorino :
	var Name : String = "Nidorino"

class Nidoking :
	var Name : String = "Nidoking"

class Melofee :
	var Name : String = "Melofee"

class Melodeffe :
	var Name : String = "Melodeffe"

class Goupix :
	var Name : String = "Goupix"

class Feunard :
	var Name : String = "Feunard"

class Rondoudou :
	var Name : String = "Rondoudou"

class Grodoudou :
	var Name : String = "Grodoudou"

class Nosferapti :
	var Name : String = "Nosferapti"

class Nosferalto :
	var Name : String = "Nosferalto"

class Mystherbe :
	var Name : String = "Mystherbe"

class Ortide :
	var Name : String = "Ortide"

class Rafflesia :
	var Name : String = "Rafflesia"

class Paras :
	var Name : String = "Paras"

class Parasect :
	var Name : String = "Parasect"

class Mimitoss :
	var Name : String = "Mimitoss"

class Aeromite :
	var Name : String = "Aeromite"

class Taupiqueur :
	var Name : String = "Taupiqueur"

class Triopikeur :
	var Name : String = "Triopikeur"

class Miaouss :
	var Name : String = "Miaouss"

class Persian :
	var Name : String = "Persian"

class Psykokwak :
	var Name : String = "Psykokwak"

class Akwakwak :
	var Name : String = "Akwakawk"

class Ferosinge :
	var Name : String = "Ferosinge"

class Colosinge :
	var Name : String = "Colosinge"

class Caninos :
	var Name : String = "Caninos"

class Arcanin :
	var Name : String = "Arcanin"

class Ptitard :
	var Name : String = "Ptitard"

class Tetarte :
	var Name : String = "Tetartre"

class Tartard :
	var Name : String = "Tartard"

class Abra :
	var Name : String = "Abra"

class Kadabra :
	var Name : String = "Kadabra"

class Alakazam :
	var Name : String = "Alakazam"

class Machoc :
	var Name : String = "Machoc" 

class Machopeur :
	var Name : String = "Machopeur"

class Mackogneur :
	var Name : String = "Mackogneur"

class Chetiflor :
	var Name : String = "Chetiflor"

class Boustiflor :
	var Name : String = "Boustiflor"

class Empiflor :
	var Name : String = "Empiflor"

class Tentacool :
	var Name : String = "Tentacool"

class Tentacruel :
	var Name : String = "Tentacruel"

class Racaillou :
	var Name : String = "Racaillou"

class Gravalanch :
	var Name : String = "Gravalanch"

class Grolem :
	var Name : String = "Grolem"

class Ponyta :
	var Name : String = "Ponyta"

class Galopa :
	var Name : String = "Galopa"

class Ramoloss :
	var Name : String = "Ramoloss"

class Flagadoss :
	var Name : String = "Flagadoss"

class Magneti :
	var Name : String = "Magneti"

class Magneton :
	var Name : String = "Magneton"

class Canarticho :
	var Name : String = "Canarticho"

class Doduo :
	var Name : String = "Doduo"

class Dodrio :
	var Name : String = "Dodrio"

class Ottaria :
	var Name : String = "Ottaria"

class Lamantine :
	var Name : String = "Lamantine"

class Tadmorv :
	var Name : String = "Tadmorv"

class Grotadmorv :
	var Name : String = "Grotadmorv"

class Kokiyas :
	var Name : String = "Kokiyas"

class Crustabri :
	var Name : String = "Crustabri"

class Fantominus :
	var Name : String = "Fantominus"

class Spectrum :
	var Name : String = "Spectrum"

class Ectoplasma :
	var Name : String = "Ectoplasma"

class Onix :
	var Name : String = "Onix"

class Soporifik :
	var Name : String = "Soporifik"

class Hypnomade :
	var Name : String = "Hypnomade"

class Krabby :
	var Name : String = "Krabby"

class Kraboss :
	var Name : String = "Kraboss"

class Voltorbe :
	var Name : String = "Voltobre"

class Electrode :
	var Name : String = "Electrode"

class Noeunoeuf :
	var Name : String = "Noeunoeuf"

class Noadkoko :
	var Name : String = "Noadkoko"

class Osselait :
	var Name : String = "Osselait"

class Ossatueur :
	var Name : String = "Ossatueur"

class Kikclee :
	var Name : String = "Kikclee"

class Tygnon :
	var Name : String = "Tygnon"

class Excelangue :
	var Name : String = "Excelangue"

class Smogo :
	var Name : String = "Smogo"

class Smogogo :
	var Name : String = "Smogogo"

class Rhinocorne :
	var Name : String = "Rhinocorne"

class Rhinoferos :
	var Name : String = "Rhinoferos"

class Leveinard :
	var Name : String = "Leveinard"

class Saquedeneu :
	var Name : String = "Saquedeneu"

class Kangourex :
	var Name : String = "Kangourex"

class Hypotrempe :
	var Name : String = "Hypotrempe"

class Hypocean :
	var Name : String = "Hypocean"

class Possirene :
	var Name : String = "Possirene"

class Poissoroy :
	var Name : String = "Poissoroy"

class Stari :
	var Name : String = "Stari"

class Staross :
	var Name : String = "Staross"

class MMime :
	var Name : String = "M.Mime"

class Insecateur :
	var Name : String = "Insecateur"

class Lippoutou :
	var Name : String = "Lippoutou"

class Eletek :
	var Name : String = "Eletek"

class Magmar :
	var Name : String = "Magmar"

class Scarabrute :
	var Name : String = "Scarabrute"

class Tauros :
	var Name : String = "Tauros"

class Magicarpe :
	var Name : String = "Magicarpe"

class Leviator :
	var Name : String = "Leviator"

class Lokhlass :
	var Name : String = "Lokhlass"

class Metamorph :
	var Name : String = "Metamorph"

class Evoli :
	var Name : String = "Evoli"

class Aquali :
	var Name : String = "Aquali"

class Voltali :
	var Name : String = "Voltali"

class Pyroli :
	var Name : String = "Pyroli"

class Porygon :
	var Name : String = "Porygon"

class Amonita :
	var Name : String = "Amonita"

class Amonistar :
	var Name : String = "Amonistar"

class Kabuto :
	var Name : String = "Kabuto"

class Kabutos :
	var Name : String = "Kabutos"

class Ptera :
	var Name : String = "Ptera"

class Ronflex :
	var Name : String = "Ronflex"

class Artikodin :
	var Name : String = "Artikodin"

class Electhor :
	var Name : String = "Electhor"

class Sulfura :
	var Name : String = "Sulfura"

class Minidraco :
	var Name : String = "Minidraco"

class Dracolosse :
	var Name : String = "Dracolosse"

class Mewtwo :
	var Name : String = "Mewtwo"

class Mew :
	var Name : String = "Mew"

class Rayquaza :
#Important Information
	var Name : String = "Rayquaza"
	var Prop = null
	var Lvl : int = 50
#Stat Information
#	Life
	var Hp : int = 210
	var MaxHp : int = 210
#Attaque
	var Puissance : int = 220
	var Defense : int = 160
	var AttaqueSpecial : int = 220
	var DefenseSpecial : int = 160
	var Vitesse : int = 140
#	Others
	var Experience : int = 0
	var LvlNeededToEvolve : int = 100
	var ExperienceNeededToLvlUp : int = 62500
	var BaseLvl : int = 220
	var Statut : String = ""
	var CatchRate : int = 3
#	Attaque Information
	var Attaque1 : String = "Ouragan"
	var Attaque2 : String = "Hydrocanon"
	var Attaque3 : String = "Feu d'Enfer"
	var Attaque4 : String = "Pique"
	var ActualPPAttaque1 : int = 0
	var ActualPPAttaque2 : int = 0
	var ActualPPAttaque3 : int = 0
	var ActualPPAttaque4 : int = 0
#Type of the Pokemon
	var Type1 : String = "Dragon"
	var Type2 : String = "Vol"
#Textures
	var TextureFront = "res://img Pokemon/All Pokemon/Front/384.png"
	var TextureBack = "res://img Pokemon/All Pokemon/back/384.png"
	var TextureOverworld = "res://img Pokemon/All Pokemon/Overworld/384.png"

var List = {
"Bulbizarre" : self.Bulbizarre,
"Herbizarre" : self.Herbizarre,
"Florizarre" : self.Florizarre,
"Salameche" : self.Salameche,
"Reptincel" : self.Reptincel, 
"Dracaufeu" : self.Dracaufeu, 
"Carapuce" : self.Carapuce, 
"Carabaffe" : self.Carabaffe,
"Tortank" : self.Tortank,
"Chenipan" : self.Chenipan,
"Chrysacier" : self.Chrysacier,
"Papilusion" : self.Papilusion,
"Aspicot" : self.Aspicot,
"Coconfort" : self.Coconfort,
"Dardagnan" : self.Dardagnan,
"Roucool" : self.Roucool,
"Roucoups" : self.Roucoups,
"Roucarnage" : self.Roucarnage,
"Rattata" : self.Rattata,
"Rattatac" : self.Rattatac,
"Rayquaza" : self.Rayquaza
}
