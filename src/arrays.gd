extends Node
class_name Arrays

static func find(array: Array, find_func: Callable) -> Variant:
    for item in array:
        if find_func.call(item):
            return item

    return null



static func random(array: Array) -> Variant:
    var rng := RandomNumberGenerator.new()
    rng.randomize()
    var random_index = rng.randi_range(0, array.size()-1)
    return array[random_index]

