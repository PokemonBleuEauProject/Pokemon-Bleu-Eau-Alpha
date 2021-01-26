extends Node

#All needed variable for Game
var BoolCC = false
var BoolCCE = false
var Efficacity1 = 1
var Efficacity2 = 1
var EvenText = ""
var SpecialText = ""
var CCSpecial = false
var CCSpecialValue = 0
var CCSpecialE = false
var CCSpecialValueE = 0

var StatutSentence = ""

var IsFlying = false
var IsFlyingE = false
var IfTornadoAndFlying = 1
var IfTornadoAndFlyingE = 1

var Protected = false
var ProtectedE = false
var ProtectedPercent = 1
var ProtectedPercentE = 1

var VampiDraine = false
var VampiDraineRound = 0
var VampiDraineE = false
var VampiDraineRoundE = 0

var AttaquePlayer = 0
var AttaqueSpecialPlayer = 0
var AttaqueEnnemi = 0
var AttaqueSpecialEnnemi = 0
var DefensePlayer = 0
var DefenseSpecialPlayer = 0
var DefenseEnnemi = 0
var DefenseSpecialEnnemi = 0
var VitessePlayer = 0
var VitesseEnnemi = 0
var PrecisionPlayer = 100
var PrecisionEnnemi = 100

#All Maths Calcul for Dammage
#Calculs finaux des dommages physiques et spéciales
func CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,Attacker) :
	var Dommage
	CheckStatVariable(PokemonPlayer,PokemonEnnemi)
	match Attacker :
		"Player" :
			Dommage = ((((((PokemonPlayer.Lvl * 2 / 5) + 2) * GetAttaquePuissance(PokemonAttaqueName) * (PokemonPlayer.Puissance + AttaquePlayer) / 50) / (PokemonEnnemi.Defense + DefenseEnnemi)) + 2) * CC(Attacker,PokemonPlayer.Lvl) * R() / 100) * Stab(PokemonAttaqueName,PokemonPlayer.Type1,PokemonPlayer.Type2) * Type1(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type1) * Type2(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type2)
		"Ennemi" :
			Dommage = ((((((PokemonPlayer.Lvl * 2 / 5) + 2) * GetAttaquePuissance(PokemonAttaqueName) * (PokemonPlayer.Puissance + AttaqueEnnemi) / 50) / (PokemonEnnemi.Defense + DefensePlayer)) + 2) * CC(Attacker,PokemonPlayer.Lvl) * R() / 100) * Stab(PokemonAttaqueName,PokemonPlayer.Type1,PokemonPlayer.Type2) * Type1(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type1) * Type2(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type2)
	return Dommage
func CalculateDammageSpe(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,Attacker) :
	var Dommage
	CheckStatVariable(PokemonPlayer,PokemonEnnemi)
	match Attacker :
		"Player" :
			Dommage = ((((((PokemonPlayer.Lvl * 2 / 5) + 2) * GetAttaquePuissance(PokemonAttaqueName) * (PokemonPlayer.AttaqueSpecial + AttaqueSpecialPlayer) / 50) / (PokemonEnnemi.DefenseSpecial + DefenseSpecialPlayer)) + 2) * CC(Attacker,PokemonPlayer.Lvl) * R() / 100) * Stab(PokemonAttaqueName,PokemonPlayer.Type1,PokemonPlayer.Type2) * Type1(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type1) * Type2(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type2)
		"Ennemi" :
			Dommage = ((((((PokemonPlayer.Lvl * 2 / 5) + 2) * GetAttaquePuissance(PokemonAttaqueName) * (PokemonPlayer.AttaqueSpecial + AttaqueSpecialEnnemi) / 50) / (PokemonEnnemi.DefenseSpecial + DefenseSpecialEnnemi)) + 2) * CC(Attacker,PokemonPlayer.Lvl) * R() / 100) * Stab(PokemonAttaqueName,PokemonPlayer.Type1,PokemonPlayer.Type2) * Type1(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type1) * Type2(GetAttaqueType(PokemonAttaqueName),PokemonEnnemi.Type2)
	return Dommage
#Verifie les coups critiques
func CC(Prop,PokemonLvl) :
	var Specialrandom = 16
	match Prop :
		"Player" :
			if CCSpecial :
				Specialrandom = CCSpecialValue
				CCSpecial = false
			var ARandom = RandomNumberGenerator.new()
			ARandom.randomize()
			var RandomNumber = ARandom.randi_range(1,Specialrandom)
			match RandomNumber :
				1 :
					BoolCC = true
					return ((2*PokemonLvl+5)/(PokemonLvl+5))
				2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 :
					BoolCC = false
					return 1
		"Ennemi" :
			if CCSpecialE :
				Specialrandom = CCSpecialValueE
				CCSpecialE = false
			var ARandom = RandomNumberGenerator.new()
			ARandom.randomize()
			var RandomNumber = ARandom.randi_range(1,Specialrandom)
			match RandomNumber :
				1 :
					BoolCCE = true
					return ((2*PokemonLvl+5)/(PokemonLvl+5))
				2,3,4,5,6,7,8,9,10,11,12,13,14,15,16 :
					BoolCCE = false
					return 1
#Un nombre aléatoire complexe chargé
func R() :
	var Random = RandomNumberGenerator.new()
	Random.randomize()
	var rand = Random.randi_range(217,255)
	return (rand * 100) / 255
#Elles verifient l'adaptabilité de l'attaque par rapport aux types du pokemon
func Stab(PokemonAttaqueName,PokemonType1,PokemonType2) :
	if (GetAttaqueType(PokemonAttaqueName) == PokemonType1) or (GetAttaqueType(PokemonAttaqueName) == PokemonType2) :
		return 1.5
	else :
		return 1
func Type1(PokemonType1,PokemonEnnemiType1) :
	Efficacity1 = Efficacity(PokemonType1,PokemonEnnemiType1)
	return Efficacity1
func Type2(PokemonType2,PokemonEnnemiType2) :
	Efficacity2 = Efficacity(PokemonType2,PokemonEnnemiType2)
	return Efficacity2
#Elle verifie l'éfficacité de l'attaque sur les pokemons
func Efficacity(Att,Def) :
	match Att :
		"Normal" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 0.5
				"Fantome" :
					return 0
				"Dragon" :
					return 1
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		"Feu" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 0.5
				"Eau" :
					return 10.5
				"Plante" :
					return 2
				"Electrik" :
					return 1
				"Glace" :
					return 2
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 2
				"Roche" :
					return 0.5
				"Fantome" :
					return 1
				"Dragon" :
					return 0.5
				"Tenebre" :
					return 1
				"Acier" :
					return 2
				_ :
					return 1
		"Eau" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 2
				"Eau" :
					return 0.5
				"Plante" :
					return 0.5
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 2
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 2
				"Fantome" :
					return 1
				"Dragon" :
					return 0.5
				"Tenebre" :
					return 1
				"Acier" :
					return 1
				_ :
					return 1
		"Plante" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 0.5
				"Eau" :
					return 2
				"Plante" :
					return 0.5
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 0.5
				"Sol" :
					return 2
				"Vol" :
					return 0.5
				"Psy" :
					return 1
				"Insecte" :
					return 0.5
				"Roche" :
					return 2
				"Fantome" :
					return 1
				"Dragon" :
					return 0.5
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		"Electrik" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 2
				"Plante" :
					return 0.5
				"Electrik" :
					return 0.5
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 0
				"Vol" :
					return 2
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 1
				"Dragon" :
					return 0.5
				"Tenebre" :
					return 1
				"Acier" :
					return 1
				_ :
					return 1
		"Glace" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 0.5
				"Eau" :
					return 0.5
				"Plante" :
					return 2
				"Electrik" :
					return 1
				"Glace" :
					return 0.5
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 2
				"Vol" :
					return 2
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 1
				"Dragon" :
					return 2
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		"Combat" :
			match Def :
				"Normal" :
					return 2
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 2
				"Combat" :
					return 1
				"Poison" :
					return 0.5
				"Sol" :
					return 1
				"Vol" :
					return 0.5
				"Psy" :
					return 0.5
				"Insecte" :
					return 0.5
				"Roche" :
					return 2
				"Fantome" :
					return 0
				"Dragon" :
					return 1
				"Tenebre" :
					return 2
				"Acier" :
					return 2
				_ :
					return 1
		"Poison" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 2
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 0.5
				"Sol" :
					return 0.5
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 0.5
				"Fantome" :
					return 0.5
				"Dragon" :
					return 1
				"Tenebre" :
					return 1
				"Acier" :
					return 0
				_ :
					return 1
		"Sol" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 2
				"Eau" :
					return 1
				"Plante" :
					return 0.5
				"Electrik" :
					return 2
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 2
				"Sol" :
					return 1
				"Vol" :
					return 0
				"Psy" :
					return 1
				"Insecte" :
					return 0.5
				"Roche" :
					return 2
				"Fantome" :
					return 1
				"Dragon" :
					return 1
				"Tenebre" :
					return 1
				"Acier" :
					return 2
				_ :
					return 1
		"Vol" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 2
				"Electrik" :
					return 0.5
				"Glace" :
					return 1
				"Combat" :
					return 2
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 2
				"Roche" :
					return 0.5
				"Fantome" :
					return 1
				"Dragon" :
					return 1
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		"Psy" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 2
				"Poison" :
					return 2
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 0.5
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 1
				"Dragon" :
					return 1
				"Tenebre" :
					return 0
				"Acier" :
					return 0.5
				_ :
					return 1
		"Insecte" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 0.5
				"Eau" :
					return 1
				"Plante" :
					return 2
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 0.5
				"Poison" :
					return 0.5
				"Sol" :
					return 1
				"Vol" :
					return 0.5
				"Psy" :
					return 2
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 0.5
				"Dragon" :
					return 1
				"Tenebre" :
					return 2
				"Acier" :
					return 0.5
				_ :
					return 1
		"Roche" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 2
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 2
				"Combat" :
					return 0.5
				"Poison" :
					return 1
				"Sol" :
					return 0.5
				"Vol" :
					return 2
				"Psy" :
					return 1
				"Insecte" :
					return 2
				"Roche" :
					return 1
				"Fantome" :
					return 1
				"Dragon" :
					return 1
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		"Fantome" :
			match Def :
				"Normal" :
					return 0
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 2
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 2
				"Dragon" :
					return 1
				"Tenebre" :
					return 0.5
				"Acier" :
					return 0.5
				_ :
					return 1
		"Dragon" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 1
				"Dragon" :
					return 2
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		"Tenebre" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 1
				"Eau" :
					return 1
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 1
				"Combat" :
					return 0.5
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 2
				"Insecte" :
					return 1
				"Roche" :
					return 1
				"Fantome" :
					return 2
				"Dragon" :
					return 1
				"Tenebre" :
					return 0.5
				"Acier" :
					return 0.5
				_ :
					return 1
		"Acier" :
			match Def :
				"Normal" :
					return 1
				"Feu" :
					return 0.5
				"Eau" :
					return 0.5
				"Plante" :
					return 1
				"Electrik" :
					return 1
				"Glace" :
					return 2
				"Combat" :
					return 1
				"Poison" :
					return 1
				"Sol" :
					return 1
				"Vol" :
					return 1
				"Psy" :
					return 1
				"Insecte" :
					return 1
				"Roche" :
					return 2
				"Fantome" :
					return 1
				"Dragon" :
					return 1
				"Tenebre" :
					return 1
				"Acier" :
					return 0.5
				_ :
					return 1
		_ :
			return 1
#Cette fonction verifie si il faut ou non afficher un message particulier et lequelles.
func EventText(Attacker) :
	var Temp1 = ""
	var Temp2 = ""
	EvenText = ""
	var ReturnValue
	match Efficacity1 :
		0.5 : Temp1 = "Ce n'est pas très efficace ..."
		1 : Temp1 = ""
		2 : Temp1 = "C'est super efficace !!"
	match Efficacity2 :
		0.5 : Temp2 = "Ce n'est pas très efficace ..."
		1 : Temp2 = ""
		2 : Temp2 = "C'est super efficace !!"
	Efficacity1 = 1
	Efficacity2 = 1
	match Attacker :
		"Player" :
			if BoolCC :
				EvenText = "Coup Critique !"
				return
		"Ennemi" :
			if BoolCCE :
				EvenText = "Coup Critique !"
				return 
	match Temp1 :
		"Ce n'est pas très efficace ..." :
			match Temp2 :
				"Ce n'est pas très efficace ..." : 
					EvenText = "Ce n'est pas du tout efficace ..."
					return
				"C'est super efficace !!" :
					EvenText = "C'est efficace !!"
					return
				"" :
					EvenText = "Ce n'est pas très efficace ..."
					return
		"C'est super efficace !!" :
			match Temp2 :
				"Ce n'est pas très efficace ..." :
					EvenText = "C'est efficace !!"
					return
				"C'est super efficace !!" :
					EvenText = "C'est extrémement efficace !!"
					return
				"" :
					EvenText = "C'est super efficace !!"
					return
		"" :
			match Temp2 :
				"Ce n'est pas très efficace ..." :
					EvenText = "Ce n'est pas très efficace ..."
					return
				"C'est super efficace !!" :
					EvenText = "C'est super efficace !!"
					return
				"" :
					EvenText = ""
					return
	EvenText = ""

#All Method attack in the game :
#Elles sont très utiles et simples a utiliser ! 
#Elles se retrouvent toutes dans la fonction d'entrée 'checkAttack()'

#Player
func charge(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func griffe(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func rugissement(PokemonPlayer,PokemonEnnemi) :
	AttaqueEnnemi = AttaqueEnnemi - PokemonEnnemi.Puissance * (1/8)
	SpecialText = "Ah, Attaque du " + PokemonEnnemi.Name + " ennemi baisse !"
func mimiqueue(PokemonPlayer,PokemonEnnemi) :
	DefenseEnnemi = DefenseEnnemi - PokemonEnnemi.Defense * (1/8)
	SpecialText = "Ah, Defense du " + PokemonEnnemi.Name + " ennemi baisse !"
func belier(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
	PokemonPlayer.Hp = PokemonPlayer.Hp - (CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")/4)
	SpecialText = PokemonPlayer.Name + " subit un contrecoup !"
func tranchherbe(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func viveattaque(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func cruailes(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func pistoletao(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func morsure(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func lanceflamme(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammageSpe(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func puissance(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	CCSpecial = true
	CCSpecialValue = 2
	SpecialText = PokemonPlayer.Name + " se gonfle !!"
func vampigraine(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	SpecialText = PokemonEnnemi.Name + " ennemi est infécté !"
	VampiDraineRound = 3
	VampiDraine = true
func ecume(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammageSpe(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var random = ARandom.randf()
	if random <= 0.1 :
		SpecialText = "Ah, Vitesse du " + PokemonEnnemi.Name + " ennemi baisse !"
		PrecisionEnnemi = PrecisionEnnemi - (PrecisionEnnemi * (1/8))
func jetdesable(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PrecisionEnnemi = PrecisionEnnemi - (PrecisionEnnemi * (1/8))
	SpecialText = "Ah, Precision du " + PokemonEnnemi.Name + " ennemi baisse !"
func secretion(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	VitesseEnnemi = VitesseEnnemi - PokemonEnnemi.Vitesse * (1/8)
	SpecialText = "Ah, Vitesse du " + PokemonEnnemi.Name + " ennemi baisse !"
func armure(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	DefensePlayer = DefensePlayer + PokemonPlayer.Defense * (1/8)
	SpecialText = PokemonPlayer.Name + " gagne en defense !"
func dardvenin(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var random = ARandom.randf()
	if random <= 0.3 :
		PokemonEnnemi.Statut = "Empoisonne"
		SpecialText = PokemonEnnemi.Name + " est empoisonné !"
func vol(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	IsFlying = true
	SpecialText = PokemonPlayer.Name + " s'est envolé !"
func coupe(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func fouetlianes(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func coupdboule(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func machouille(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var random = ARandom.randf()
	if random <= 0.2 :
		SpecialText = "Ah, Defense Speciale du " + PokemonEnnemi.Name + " ennemi baisse !"
		DefenseSpecialEnnemi = DefenseSpecialEnnemi - PokemonEnnemi.DefenseSpecial * (1/8)
func tornade(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - (CalculateDammageSpe(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")*IfTornadoAndFlying)
	IfTornadoAndFlying = 1
func damocles(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
	PokemonPlayer.Hp = PokemonPlayer.Hp - (CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")/4)
	SpecialText = PokemonPlayer.Name + " subit un contrecoup !"
func vibraqua(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammageSpe(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func hydroqueue(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Player")
func abri(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	Protected = true
	ProtectedPercent /= 2
#Ennemi (le E signifie ennemi au user)
func chargeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func griffeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func rugissementE(PokemonPlayer,PokemonEnnemi) :
	AttaquePlayer = AttaquePlayer - PokemonPlayer.Puissance * (1/8)
	SpecialText = "Ah, Attaque du " + PokemonPlayer.Name + " baisse !"
func mimiqueueE(PokemonPlayer,PokemonEnnemi) :
	DefensePlayer = DefensePlayer - PokemonPlayer.Puissance * (1/8)
	SpecialText = "Ah, Attaque du " + PokemonPlayer.Name + " baisse !"
func belierE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - (CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")/4)
	SpecialText = PokemonEnnemi.Name + " ennemi subit un contrecoup !"
func tranchherbeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func viveattaqueE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func cruailesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func pistoletaoE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func morsureE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func lanceflammeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammageSpe(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func puissanceE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	CCSpecialE = true
	CCSpecialValueE = 2
	SpecialText = PokemonEnnemi.Name + " se gonfle !!"
func vampigraineE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	SpecialText = "Votre pokemon est infécté !"
	VampiDraineRoundE = 3
	VampiDraineE = true
func ecumeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammageSpe(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var random = ARandom.randf()
	if random <= 0.1 :
		SpecialText = "Ah, Vitesse du " + PokemonPlayer.Name + " baisse !"
		PrecisionPlayer = PrecisionPlayer - (PrecisionPlayer * (1/8))
func jetdesableE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PrecisionPlayer = PrecisionPlayer - (PrecisionPlayer * (1/8))
	SpecialText = "Ah, Precision du " + PokemonPlayer.Name + " baisse !"
func secretionE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	VitessePlayer = VitessePlayer - PokemonPlayer.Vitesse * (1/8)
	SpecialText = "Ah, Vitesse du " + PokemonPlayer.Name + " baisse !"
func armureE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	DefensePlayer = DefensePlayer + PokemonEnnemi.Defense * (1/8)
	SpecialText = PokemonEnnemi.Name + " ennemi gagne en defense !"
func dardveninE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Ennemi")
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var random = ARandom.randf()
	if random <= 0.3 :
		PokemonPlayer.Statut = "Empoisonne"
		SpecialText = PokemonPlayer.Name + " est empoisonné !"
	else :
		pass
func volE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	IsFlyingE = true
	SpecialText = PokemonEnnemi.Name + " s'est envolé !"
func coupeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func fouetlianesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func coupdbouleE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func machouilleE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Ennemi")
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var random = ARandom.randf()
	if random <= 0.2 :
		SpecialText = "Ah, Defense Speciale du " + PokemonPlayer.Name + " ennemi baisse !"
		DefenseSpecialPlayer = DefenseSpecialPlayer - PokemonPlayer.DefenseSpecial * (1/8)
func tornadeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - (CalculateDammageSpe(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,"Ennemi")*IfTornadoAndFlyingE)
	IfTornadoAndFlyingE = 1
func damoclesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - (CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")/4)
	SpecialText = PokemonEnnemi.Name + " ennemi subit un contrecoup !"
func vibraquaE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammageSpe(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func hydroqueueE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage(PokemonAttaqueName,PokemonEnnemi,PokemonPlayer,"Ennemi")
func abriE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName):
	ProtectedE = true
	ProtectedPercentE /= 2
#Secondaries functions for attacks method
func UseVol(PokemonPlayer,PokemonEnnemi) :
	PokemonEnnemi.Hp = PokemonEnnemi.Hp - CalculateDammage("Vol",PokemonEnnemi,PokemonPlayer,"Player")
	IsFlying = false
func UseVolE(PokemonPlayer,PokemonEnnemi) :
	PokemonPlayer.Hp = PokemonPlayer.Hp - CalculateDammage("Vol",PokemonEnnemi,PokemonPlayer,"Ennemi")
	IsFlyingE = false
func DrainVampigraine(PokemonPlayer,PokemonEnnemi) :
	if VampiDraineRound == 0 :
		VampiDraine = false
	elif PokemonEnnemi.Hp > 16 :
		PokemonEnnemi.Hp = PokemonEnnemi.Hp - (PokemonEnnemi.Hp * 0.125)
		PokemonPlayer.Hp = PokemonPlayer.Hp + (PokemonEnnemi.Hp * 0.125)
	else :
		PokemonEnnemi.Hp = PokemonEnnemi.Hp - 1
		PokemonPlayer.Hp = PokemonPlayer.Hp + 1
	VampiDraineRound = VampiDraineRound - 1
func DrainVampigraineE(PokemonPlayer,PokemonEnnemi) :
	if VampiDraineRoundE == 0 :
		VampiDraineE = false
	elif PokemonPlayer.Hp > 16 :
		PokemonPlayer.Hp = PokemonPlayer.Hp - (PokemonPlayer.Hp * 0.125)
		PokemonEnnemi.Hp = PokemonEnnemi.Hp - (PokemonPlayer.Hp * 0.125)
	else :
		PokemonPlayer.Hp = PokemonPlayer.Hp - 1
		PokemonEnnemi.Hp = PokemonEnnemi.Hp + 1
	VampiDraineRoundE = VampiDraineRoundE - 1

#Statuts Functions :
#Toutes les fonctions concernant le statut
func GetAndSetStatut(ThePokemon) :
	if ThePokemon.Statut != "" :
		return ThePokemon.Statut
	else : return "-"
func CheckPokemonStatut(ThePokemon) :
	if ThePokemon.Statut != "" :
		match ThePokemon.Statut :
			"Empoisonne" :
				Poison(ThePokemon)
				StatutSentence = ThePokemon.Name + " souffre du poison !"
			"Paralyse" :
#				Paralyse
				pass
		return true
	else : return false
func Poison(ThePokemon) :
	if (ThePokemon.Hp < 16) :
		ThePokemon.Hp = ThePokemon.Hp - 1
	else :
		ThePokemon.Hp = ThePokemon.Hp - (ThePokemon.Hp / 8)

#Others Functions : 
#Des fonctions qui verifient certaines conditions ou verifient
func CheckAttack(PokemonAttaqueName,PokemonPlayer,PokemonEnnemi,WhoAttack) :
	match WhoAttack :
		"Player" :
			match PokemonAttaqueName :
				"Charge" : charge(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Griffe" : griffe(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Mimi Queue" : mimiqueue(PokemonPlayer,PokemonEnnemi)
				"Rugissement" : rugissement(PokemonPlayer,PokemonEnnemi)
				"Belier" : belier(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Tranch'Herbe" : tranchherbe(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vive Attaque" : viveattaque(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Cru Ailes" : cruailes(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Pistolet a O" : pistoletao(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Morsure" : morsure(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Lance Flamme" : lanceflamme(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Puissance" : puissance(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vampigraine" : vampigraine(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Ecume" : ecume(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Jet de sable" : jetdesable(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Secretion" : secretion(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Armure" : armure(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Dard Venin" : dardvenin(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vol" : vol(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Coupe" : coupe(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Fouet Lianes" : fouetlianes(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Coup d'Boule" : coupdboule(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Machouille" : machouille(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Tornade" : tornade(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Damocles" : damocles(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vibraqua" : vibraqua(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
		"Ennemi" :
			match PokemonAttaqueName :
				"Charge" : chargeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Griffe" : griffeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Mimi Queue" : mimiqueueE(PokemonPlayer,PokemonEnnemi)
				"Rugissement" : rugissementE(PokemonPlayer,PokemonEnnemi)
				"Belier" : belierE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Tranch'Herbe" : tranchherbeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vive Attaque" : viveattaqueE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Cru Ailes" : cruailesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Pistolet a O" : pistoletaoE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Morsure" : morsureE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Lance Flamme" : lanceflammeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Puissance" : puissanceE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vampigraine" :vampigraineE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Ecume" : ecumeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Jet de sable" : jetdesableE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Secretion" : secretionE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Armure" : armureE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Dard Venin" : dardveninE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vol" : volE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Coupe" : coupeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Fouet Lianes" : fouetlianesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Coup d'Boule" : fouetlianesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Machouille" : machouilleE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Tornade" : tornadeE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Damocles" : damoclesE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
				"Vibraqua" : vibraquaE(PokemonPlayer,PokemonEnnemi,PokemonAttaqueName)
func CheckSuccess(Attacker,PokemonAttaqueName) :
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var Random = ARandom.randf_range(0,100)
	match Attacker :
		"Player" :
			if ProtectedE : return false
			elif PokemonAttaqueName == "Vol" and (GetAttaquePrecision(PokemonAttaqueName)+PrecisionPlayer >= Random) :
				return true
			elif (IsFlyingE) and (PokemonAttaqueName == "Tornade") :
				IfTornadoAndFlying = 2
				return true
			elif IsFlyingE : return false
			elif (GetAttaquePrecision(PokemonAttaqueName)+PrecisionPlayer >= Random) : return true
			else : return false
		"Ennemi" :
			if Protected : return false
			elif PokemonAttaqueName == "Vol" and (GetAttaquePrecision(PokemonAttaqueName)+PrecisionEnnemi >= Random) :
				return true
			elif IsFlying and PokemonAttaqueName == "Tornade" : 
				IfTornadoAndFlyingE = 2
				return true
			elif IsFlying : return false
			elif (GetAttaquePrecision(PokemonAttaqueName)+PrecisionEnnemi >= Random) : return true
			else : return false
func CheckPP(ThePokemon,AttaqueNumber) :
	match AttaqueNumber :
		"1" :
			ThePokemon.ActualPPAttaque1 = ThePokemon.ActualPPAttaque1 - 1
			if ThePokemon.ActualPPAttaque1 >= 0 : return true
			else : return false
		"2" :
			ThePokemon.ActualPPAttaque2 = ThePokemon.ActualPPAttaque2 - 1
			if ThePokemon.ActualPPAttaque2 >= 0 : return true
			else : return false
		"3" :
			ThePokemon.ActualPPAttaque3 = ThePokemon.ActualPPAttaque3 - 1
			if ThePokemon.ActualPPAttaque3 >= 0 : return true
			else : return false
		"4" :
			ThePokemon.ActualPPAttaque4 = ThePokemon.ActualPPAttaque4 - 1
			if ThePokemon.ActualPPAttaque4 >= 0 : return true
			else : return false
		_ :
			return true
func CheckStatVariable(PokemonPlayer,PokemonEnnemi) :
	if AttaquePlayer + PokemonPlayer.Puissance < PokemonPlayer.Puissance * 0.25 : AttaquePlayer = PokemonPlayer.Puissance * 0.25
	if AttaquePlayer + PokemonPlayer.Puissance > PokemonPlayer.Puissance * 4 : AttaquePlayer = PokemonPlayer.Puissance * 4
	if AttaqueSpecialPlayer + PokemonPlayer.AttaqueSpecial < PokemonPlayer.AttaqueSpecial * 0.25 : AttaqueSpecialPlayer = PokemonPlayer.AttaqueSpecial * 0.25
	if AttaqueSpecialPlayer + PokemonPlayer.AttaqueSpecial > PokemonPlayer.AttaqueSpecial * 4 : AttaqueSpecialPlayer = PokemonPlayer.AttaqueSpecial * 4
	if AttaqueEnnemi + PokemonEnnemi.Puissance < PokemonEnnemi.Puissance * 0.25 :  AttaqueEnnemi = PokemonEnnemi.Puissance * 0.25
	if AttaqueEnnemi + PokemonEnnemi.Puissance > PokemonEnnemi.Puissance * 4 : AttaqueEnnemi = PokemonEnnemi.Puissance * 4
	if AttaqueSpecialEnnemi + PokemonEnnemi.AttaqueSpecial < PokemonEnnemi.AttaqueSpecial * 0.25 : AttaqueSpecialEnnemi = PokemonEnnemi.AttaqueSpecial * 0.25
	if AttaqueSpecialEnnemi + PokemonEnnemi.AttaqueSpecial > PokemonEnnemi.AttaqueSpecial * 4 : AttaqueSpecialEnnemi = PokemonEnnemi.AttaqueSpecial * 4
	if DefensePlayer + PokemonPlayer.Defense < PokemonPlayer.Defense * 0.25 : DefensePlayer = PokemonPlayer.Defense * 0.25
	if DefensePlayer + PokemonPlayer.Defense > PokemonPlayer.Defense * 4 : DefensePlayer = PokemonPlayer.Defense * 4
	if DefenseSpecialPlayer + PokemonPlayer.DefenseSpecial < PokemonPlayer.DefenseSpecial * 0.25 : DefenseSpecialPlayer = PokemonPlayer.DefenseSpecial * 0.25
	if DefenseSpecialPlayer + PokemonPlayer.DefenseSpecial > PokemonPlayer.DefenseSpecial * 4 : DefenseSpecialPlayer = PokemonPlayer.DefenseSpecial * 4
	if DefenseEnnemi + PokemonEnnemi.Defense < PokemonEnnemi.Defense * 0.25 : DefenseEnnemi = PokemonEnnemi.Defense * 0.25
	if DefenseEnnemi + PokemonEnnemi.Defense > PokemonEnnemi.Defense * 4 : DefenseEnnemi = PokemonEnnemi.Defense * 4
	if DefenseSpecialEnnemi + PokemonEnnemi.DefenseSpecial < PokemonEnnemi.DefenseSpecial * 0.25 : DefenseSpecialEnnemi = PokemonEnnemi.DefenseSpecial * 0.25
	if DefenseSpecialEnnemi + PokemonEnnemi.DefenseSpecial > PokemonEnnemi.DefenseSpecial * 4 : DefenseSpecialEnnemi = PokemonEnnemi.DefenseSpecial * 4
	if VitessePlayer + PokemonPlayer.Vitesse < PokemonPlayer.Vitesse * 0.25 : VitessePlayer = PokemonPlayer.Vitesse * 0.25
	if VitessePlayer + PokemonPlayer.Vitesse > PokemonPlayer.Vitesse * 4 : VitessePlayer = PokemonPlayer.Vitesse * 4
	if VitesseEnnemi + PokemonEnnemi.Vitesse < PokemonEnnemi.Vitesse * 0.25 : VitesseEnnemi = PokemonEnnemi.Vitesse * 0.25
	if VitesseEnnemi + PokemonEnnemi.Vitesse > PokemonEnnemi.Vitesse * 4 : VitesseEnnemi = PokemonEnnemi.Vitesse * 4
	if PrecisionPlayer < 25 : PrecisionPlayer = 25
	if PrecisionPlayer > 400 : PrecisionPlayer = 400
	if PrecisionEnnemi < 25 : PrecisionEnnemi = 25
	if PrecisionEnnemi > 400 : PrecisionEnnemi = 400
#Des fonctions qui prenent et renvoi des informations simples mais utiles
func GetAttaqueMaxPP(PokemonAttaque) :
	for x in List :
		if (x == PokemonAttaque) :
			return List[x].MaxPP
		else :
			pass
func GetAttaqueType(PokemonAttaque) :
	for x in List :
		if (x == PokemonAttaque) :
			return List[x].Type
		else :
			pass
func GetAttaquePuissance(PokemonAttaque) :
	for x in List :
		if (x == PokemonAttaque) :
			return List[x].Puissance
		else :
			pass
func GetAttaquePrecision(PokemonAttaque) :
	for x in List :
		if (x == PokemonAttaque) :
			return List[x].Precision
		else :
			pass
func GetFirstAttacker(VitessePokemonPlayer,VitessePokemonEnnemi,PokemonAttaqueName) :
	for x in ListSpecialSpeed :
		if PokemonAttaqueName == x :
			return true
	if VitessePokemonPlayer+VitessePlayer > VitessePokemonEnnemi+VitesseEnnemi :
		return true
	elif VitessePokemonPlayer+VitessePlayer < VitessePokemonEnnemi+VitesseEnnemi :
		return false
	else :
		return true
#Others Actions
#Reload Variables
func reaload() :
	BoolCC = false
	BoolCCE = false
	Efficacity1 = 1
	Efficacity2 = 1
	EvenText = ""
	SpecialText = ""
	CCSpecial = false
	CCSpecialValue = 0
	CCSpecialE = false
	CCSpecialValueE = 0
	StatutSentence = ""
	IsFlying = false
	IsFlyingE = false
	IfTornadoAndFlying = 1
	IfTornadoAndFlyingE = 1
	Protected = false
	ProtectedE = false
	ProtectedPercent = 1
	ProtectedPercentE = 1
	VampiDraine = false
	VampiDraineRound = 0
	VampiDraineE = false
	VampiDraineRoundE = 0
	AttaquePlayer = 0
	AttaqueSpecialPlayer = 0
	AttaqueEnnemi = 0
	AttaqueSpecialEnnemi = 0
	DefensePlayer = 0
	DefenseSpecialPlayer = 0
	DefenseEnnemi = 0
	DefenseSpecialEnnemi = 0
	VitessePlayer = 0
	VitesseEnnemi = 0
	PrecisionPlayer = 100
	PrecisionEnnemi = 100
#Calcul pour attraper le pokemon
func CatchAPokemon(PokemonMaxHp,PokemonHp,PokemonCatchRate,PokemonStatut,PokeballBonus) :
	var a = (0.33 * (PokemonHp/PokemonMaxHp) * PokemonCatchRate * StatutBonus(PokemonStatut) * PokeballBonus)
	var ARandom = RandomNumberGenerator.new()
	var TheRandom
	if a >= 255 :
		for x in range(0,3) : UIAction.CatchShiver[x] = true
	else :
		var b = 65535 * pow(a/255,0.25)
		for x in range(0,3) :
			ARandom.randomize()
			TheRandom = ARandom.randf_range(0,65535)
			if TheRandom < b :
				UIAction.CatchShiver[x] = false
			else :
				UIAction.CatchShiver[x] = true
#Calcul du bonus du au statut pour la fonction catch pokemon
func StatutBonus(PokemonStatut) :
	match PokemonStatut :
		""," ",null :
			return 1
		"Empoisonne","Paralyse","Brule" :
			return 1.5
		"Endormi","Gele" :
			return 2
		_ :
			return 1
#Fonction fuite utilisée pour verifier si le joueur peut fuire ou non
func fuite(PokemonVitesse,EnnemiPokemonVitesse) :
	if (UIFight.TypeOfFight == "FightDresseur") :
		return false
	else :
		var ARandom = RandomNumberGenerator.new()
		ARandom.randomize()
		var B = EnnemiPokemonVitesse+VitesseEnnemi/4
		if (B == 0) :
			return true
		else :
			var resultat = (32*(PokemonVitesse+VitessePlayer)) / B
			var Random = ARandom.randi_range(1,255)
			if (255 < resultat) :
				return true
			elif (resultat < 255) :
				if (Random < resultat) :
					return true
				else :
					return false

#All Dico Attaque in the Game :
#Ils référencent les parametres des attaques utilisées lors des appels des fonctions In-Fight
var Charge = {Type = "Normal",Puissance = 40,Precision = 100,MaxPP = 35}
var Griffe = {Type = "Normal",Puissance = 40,Precision = 100,MaxPP = 35}
var MimiQueue = {Type = "Normal",Puissance = 0,Precision = 100,MaxPP = 30}
var Rugissement = {Type = "Normal",Puissance = 0,Precision = 100,MaxPP = 40}
var Belier = {Type = "Normal",Puissance = 90,Precision = 85,MaxPP = 20}
var TranchHerbe = {Type = "Plante",Puissance = 55,Precision = 95,MaxPP = 25}
var ViveAttaque = {Type = "Normal",Puissance = 40,Precision = 100, MaxPP = 30}
var CruAiles = {Type = "Vol",Puissance = 60,Precision = 100, MaxPP = 35}
var PistoletAO = {Type = "Eau", Puissance = 40,Precision = 100,MaxPP = 25}
var Morsure = {Type = "Tenebre", Puissance = 60,Precision = 100,MaxPP = 25}
var LanceFlamme = {Type = "Feu",Puissance = 95,Precision = 100,MaxPP = 15}
var Puissance = {Type = "Normal",Precision = 100,MaxPP = 30}
var Vampigraine = {Type = "Plante",Precision = 90,MaxPP = 10}
var Ecume = {Type = "Eau",Puissance = 40,Precision = 100,MaxPP = 30}
var Jetdesable = {Type = "Normal",Precision = 100,MaxPP = 15}
var Secretion = {Type = "Insecte",Precision = 95, MaxPP = 40}
var Armure = {Type = "Normal",Precision = 100,MaxPP = 30}
var DardVenin = {Type = "Poison",Puissance = 15,Precision = 100,MaxPP = 35}
var Vol = {Type="Vol",Puissance = 90,Precision = 95,MaxPP = 15}
var Coupe = {Type="Normal",Puissance = 50,Precision = 95,MaxPP = 30}
var FouetLianes = {Type="Plante",Puissance = 45, Precision = 100, MaxPP = 25}
var CoupDBoule = {Type="Normal",Puissance = 70, Precision = 100, MaxPP = 15}
var Machouille = {Type = "Tenebre", Puissance = 80,Precision = 100,MaxPP = 15}
var Tornade = {Type = "Vol", Puissance = 40,Precision = 100,MaxPP = 35}
var Damocles = {Type="Normal",Puissance = 120,Precision = 100,MaxPP = 15}
var Vibraqua = {Type="Eau",Puissance = 60,Precision = 100,MaxPP = 20}
var Hydroqueue = {Type="eau",Puissance = 90,Precision = 90,MaxPP = 10}
var Abri = {Type="Normal",MaxPP = 10}
#Liste des Attaques Special (vitesse)
var ListSpecialSpeed = {"Vive Attaque" : ViveAttaque}
#Liste de toures ces attaques pour un référencement
var List = {
	"Charge" : Charge,
	"Mimi Queue" : MimiQueue,
	"Griffe" : Griffe, 
	"Rugissement" : Rugissement,
	"Belier" : Belier,
	"Tranch'Herbe" : TranchHerbe,
	"Vive Attaque" : ViveAttaque,
	"Cru Ailes" : CruAiles,
	"Pistolet a O" : PistoletAO,
	"Morsure" : Morsure,
	"Lance Flamme" : LanceFlamme,
	"Puissance" : Puissance,
	"Vampigraine" : Vampigraine,
	"Ecume" : Ecume,
	"Jet de sable" : Jetdesable,
	"Secretion" : Secretion,
	"Armure" : Armure,
	"Dard Venin" :DardVenin,
	"Vol" : Vol,
	"Coupe" : Coupe,
	"Fouet Lianes" : FouetLianes,
	"Coup d'Boule" : CoupDBoule,
	"Machouille" : Machouille,
	"Tornade" : Tornade,
	"Damocles" : Damocles,
	"Vibraqua" : Vibraqua,
	"Hydroqueue" : Hydroqueue,
	"Abri" : Abri
	}
