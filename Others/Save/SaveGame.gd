extends Node

var save_path = "user://save.dat"

var AllData = {
	"PG.PlayerName" : "Mateo",
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime}
var ListVariable = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime}
var DefaulValue = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : null,
	"PG.Pokemon3" : null,
	"PG.Pokemon4" : null,
	"PG.Pokemon5" : null,
	"PG.Pokemon6" : null,
	"PG.GameTime" : {Minutes = 0,Hours = 0,Days = 0}}

func saveActualData() : 
	ListVariable = {
	"PG.PlayerName" : PG.PlayerName,
	"PG.Pokemon1" : PG.Pokemon1,
	"PG.Pokemon2" : PG.Pokemon2,
	"PG.Pokemon3" : PG.Pokemon3,
	"PG.Pokemon4" : PG.Pokemon4,
	"PG.Pokemon5" : PG.Pokemon5,
	"PG.Pokemon6" : PG.Pokemon6,
	"PG.GameTime" : PG.GameTime
	}
func loadActualData(TheData) :
	match TheData :
		"PG.PlayerName" : PG.PlayerName = AllData[TheData]
		"PG.Pokemon1" : PG.Pokemon1 = AllData[TheData]
		"PG.Pokemon2" : PG.Pokemon2 = AllData[TheData]
		"PG.Pokemon3" : PG.Pokemon3 = AllData[TheData]
		"PG.Pokemon4" : PG.Pokemon4 = AllData[TheData]
		"PG.Pokemon5" : PG.Pokemon5 = AllData[TheData]
		"PG.Pokemon6" : PG.Pokemon6 = AllData[TheData]
		"PG.GameTime" : PG.GameTime = AllData[TheData]

func saveData() :
	saveActualData()
	AllData = ListVariable
func loadData() :
	for x in AllData :
		loadActualData(x)

func saveGame() :
	var save = File.new()
	var error = save.open(save_path,File.WRITE)
	if error == OK :
		saveData()
		save.store_var(AllData)
		save.close()

func loadGame() :
	var save = File.new()
	if save.file_exists(save_path) :
		var error = save.open(save_path,File.READ)
		if error == OK :
			loadData()
			save.close()

func deleteSave() :
	AllData = DefaulValue
	loadGame()
