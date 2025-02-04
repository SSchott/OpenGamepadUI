extends Control

signal notification_received
signal notification_finished

var NotificationManager := load("res://core/global/notification_manager.tres") as NotificationManager
var default_icon := preload("res://icon.svg")

@onready var panel := $%PanelContainer as PanelContainer
@onready var texture := $%TextureRect as TextureRect
@onready var label := $%Label as Label
@onready var effect := $%SlideEffect as SlideEffect
@onready var timer := $%TimeoutTimer as Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.visible = false
	# Subscribe to any notifications
	NotificationManager.notification_queued.connect(_on_notification_queued)
	_on_notification_queued.call_deferred(null)
	
	# Continue showing any other queued messages
	var on_finished := func():
		_on_notification_queued(null)
	effect.slide_out_finished.connect(on_finished)


# Show notifications when they are queued
func _on_notification_queued(_notify: Notification) -> void:
	if _is_showing():
		return
	# TODO: Only consume the notification if in in-game state
	var notify := NotificationManager.next()
	if not notify:
		return
	show_toast(notify.text, notify.icon, notify.timeout)


func _is_showing() -> bool:
	return panel.visible


# Shows the toast with the given text and icon which will be dismissed after
# the given timeout.
func show_toast(text: String, icon: Texture2D = null, timeout_sec: float = 5.0):
	# Set the toast's text and icon
	label.text = text
	texture.texture = default_icon
	if icon != null:
		texture.texture = icon
	
	# Setup and start the timer to dismiss the toast
	var hide_toast := func():
		notification_finished.emit()
	timer.timeout.connect(hide_toast, CONNECT_ONE_SHOT)
	timer.start(timeout_sec)
	notification_received.emit()
	
