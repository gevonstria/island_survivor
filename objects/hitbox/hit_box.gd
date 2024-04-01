extends Area3D

signal register_hit

@export var hit_audio_key = SFXConfig.Keys.TreeHit
@export var hit_particle_key = VFXConfig.Keys.HitParticlesWood

func take_hit(weapon_item_resource):
	register_hit.emit(weapon_item_resource)
	EventSystem.SFX_play_dynamic_sfx.emit(hit_audio_key, global_position)
