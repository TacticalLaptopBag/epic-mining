extends RefCounted
class_name ResourceArray

var dir: DirAccess
var dir_path: String

func _init(path: String):
    dir_path = path
    dir = DirAccess.open(path)

func loadAll() -> Array:
    assert(dir, "Specified path does not exist!")
    var resources: Array = []
    
    dir.list_dir_begin()
    var file_name := dir.get_next()
    while file_name != "":
        if file_name.ends_with(".import"):
            file_name = dir.get_next()
            continue

        var rsc_path := dir_path+"/"+file_name
        var resource := load(rsc_path)
        resources.push_back(resource)
        file_name = dir.get_next()
    
    return resources
