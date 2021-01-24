extends Object

class_name SaveFile

const FILE_LOCATION: String = 'user://savefile.txt'
const CURRENT_VERSION: int = 0

const KEY_DATA: String = 'data'
const KEY_UNLOCKED: String = 'unlocked'
const KEY_BEST_TIME: String = 'best'
const KEY_VERSION: String = 'version'

var level_array: Array
var version: int

func _init():
	print('Creating save file')
	
	if !_get_old_data():
		_make_new_data()
		save()
	else:
		print('Save data loaded')

func _get_old_data() -> bool:
	var dir: Directory = Directory.new()
	
	if !dir.file_exists(FILE_LOCATION):
		print('Save file does not exist')
		return false
	
	var file: File = File.new()
	
	if file.open(FILE_LOCATION, File.READ) != OK:
		print('Cannot open save file')
		return false
	
	var data = parse_json(file.get_line())
	
	if data == null:
		print('Save data corrupted')
		return false
		
	file.close()
	
	if data[KEY_VERSION] < CURRENT_VERSION:
		print('Save data is old.')
		return false
		
	level_array = data[KEY_DATA]
	
	return true

func _make_new_data():
	print('Creating new data')
	level_array = []
	
	for level in Levels.array:
		var data = {
			KEY_UNLOCKED: false,
			KEY_BEST_TIME: -1
		}
		level_array.append(data)
		
	version = CURRENT_VERSION
	
	level_array[0][KEY_UNLOCKED] = true
	
	return level_array

func save():
	var file: File = File.new()
	
	if file.open(FILE_LOCATION, File.WRITE) != OK:
		print('Failed to save file.')
	
	var data = {
		KEY_VERSION: version,
		KEY_DATA: level_array
	}
	
	file.store_line(to_json(data))
	
	file.close()

func is_level_unlocked(index: int) -> bool:
	return level_array[index][KEY_UNLOCKED]

func get_level_best_time(index: int) -> float:
	# Returns -1 if no best set
	var best = level_array[index][KEY_BEST_TIME]
	if best == null:
		return float(-1)
	
	return float(best)

func get_level_from_scene(scene: String):
	for i in range(len(level_array)):
		if scene == Levels.array[i][1]:
			return i
	
	return -1

func set_best_time(index: int, time: float):
	level_array[index][KEY_BEST_TIME] = time
	if index < len(level_array) - 1:
		level_array[index+1][KEY_UNLOCKED] = true
