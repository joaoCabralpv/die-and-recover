extends Node

var _UnlokedLevels: Array[String] = ["1"]

func unlock_level(level:String):
	_UnlokedLevels.push_back(level)
