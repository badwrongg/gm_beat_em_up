switch (++load_step)
{
	case 0: // Navigation
		mp_grid_add_instances(global.navgrid, __collider_all, true);
	break;
	
	case 1: // Spawn player
		instance_create_layer(x, y, layer, entity_player);
	break;
	
	default:
		audio_group_stop_all(audio_bgm);
		global.bmg_track = audio_play_sound(room_bgm, 1, true);
		global.room_loaded = true;
		instance_destroy(id);
}



