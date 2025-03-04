extends Timer

signal time_up

@onready var front_time_label: RichTextLabel = %FrontTimeLabel
@onready var back_time_label: RichTextLabel = %BackTimeLabel

const initialTime : int = 30

var timeAmount : float = initialTime
var lastSecond : int = initialTime

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_restart_time()


func _process(delta: float) -> void:
	if (time_left < lastSecond - 1):
		lastSecond -= 1
		front_time_label.text = "Time: " + str(lastSecond)
		back_time_label.text = "Time: " + str(lastSecond)


func _on_timeout() -> void:
	emit_signal("time_up")


func _restart_time() -> void:
	timeAmount = initialTime
	lastSecond = initialTime
	start(timeAmount)
	front_time_label.text = "Time: " + str(lastSecond)
	back_time_label.text = "Time: " + str(lastSecond)
