extends Node

var thread


func _ready():
	thread = Thread.new() # create thread
	print("Create Thread Id: ", thread)
	print("Thread Active: ", thread.is_alive())
	
	thread.start(startTimer, 0) # start the thread
	#startTimer()
	print("\nStart the thread: ")
	print("Thread Active: ", thread.is_alive())
	
	var waitForThread = await thread.wait_to_finish() # wait for our thread to finish before moving on
	print("\nThread is Finished: ", waitForThread)
	print("Thread Active: ", thread.is_alive())
	


func startTimer():
	await get_tree().create_timer(1).timeout
	print("\ntimer done!")
	return 100
