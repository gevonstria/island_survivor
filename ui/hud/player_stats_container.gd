extends VBoxContainer

@onready var energy_bar: TextureProgressBar = $EnergyBar
@onready var health_bar: TextureProgressBar = $HealthBar

func _enter_tree() -> void:
	if not EventSystem.PLA_energy_updated.is_connected(energy_updated):
		EventSystem.PLA_energy_updated.connect(energy_updated)
	if not EventSystem.PLA_health_updated.is_connected(health_updated):
		EventSystem.PLA_health_updated.connect(health_updated)
	
func energy_updated(max_energy, current_energy):
	energy_bar.max_value = max_energy
	energy_bar.value = current_energy
	
func health_updated(max_health, current_health):
	health_bar.max_value = max_health
	health_bar.value = current_health
