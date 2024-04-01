extends Node

signal BUL_create_bulletin
signal BUL_destroy_bulletin
signal BUL_destroy_all_bulletins

signal INV_try_to_pickup_item
signal INV_ask_update_inventory
signal INV_inventory_updated
signal INV_hotbar_updated
signal INV_switch_to_item_indexes
signal INV_add_item
signal INV_delete_crafting_blueprint_cost
signal INV_delete_item_by_index
signal INV_add_item_by_index

signal PLA_freeze_player
signal PLA_unfreeze_player
signal PLA_change_energy
signal PLA_energy_updated
signal PLA_change_health
signal PLA_health_updated
signal PLA_sleep

signal EQU_hotkey_pressed
signal EQU_equip_item
signal EQU_unequip_item
signal EQU_active_hotbar_slot_updated
signal EQU_delete_equip_item

signal SPA_spawn_scene
signal SPA_spawn_vfx

signal SFX_play_sfx
signal SFX_play_dynamic_sfx

signal MUS_play_music

signal GAM_fast_forward_day_night_anim
signal GAM_game_fade_in
signal GAM_game_fade_out
signal GAM_update_navmesh

signal STA_change_stage

signal HUD_hide_hud
signal HUD_show_hud

signal SET_music_volume_changed
signal SET_sfx_volume_changed
signal SET_res_scale_changed
signal SET_ssaa_changed
signal SET_fullscreen_changed
signal SET_ask_settings_resource
signal SET_save_settings
