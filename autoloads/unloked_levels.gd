extends Node

var _UnlokedLevels: Array[String] = ["1"]
var AllUnlocked = true

func unlock_level(level:String):
	_UnlokedLevels.push_back(level)
