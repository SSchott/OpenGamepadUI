extends Control

@onready var state_manager: StateManager = get_node("/root/Main/StateManager")
@onready var launch_button: Button = $ScrollContainer/VBoxContainer/LaunchBarMargin/LaunchBar/LaunchButtonContainer/LaunchButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_manager.state_changed.connect(_on_state_changed)
	visible = false
	
	
func _on_state_changed(from: StateManager.State, to: StateManager.State, data: Dictionary):
	visible = state_manager.has_state(StateManager.State.GAME_LAUNCHER)
	if not visible:
		return
	if to == StateManager.State.IN_GAME:
		state_manager.remove_state(StateManager.State.GAME_LAUNCHER)

	# Focus the first entry on state change
	launch_button.grab_focus.call_deferred()