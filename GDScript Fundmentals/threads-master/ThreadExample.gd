extends Node

var threads_finished = 0
var threads = []
var mutex = Mutex.new()

func _ready():
	for i in 100:
		threads.push_back(Thread.new())
		threads[-1].start(thread_func.bind(randf_range(1.0, 5.0)))
		
func thread_func(workload): 
	await get_tree().create_timer(workload).timeout
	mutex.lock()
	threads_finished += 1
	print("Thread ", threads_finished, " done")
	if threads_finished == threads.size():
		call_deferred("done")
	mutex.unlock()

func done():
	print("All finished, destroying thread objects")
