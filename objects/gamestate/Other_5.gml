game_state         = gs_room_load_world;
game_paused        = true;

if (global.navgrid != noone)
	mp_grid_destroy(global.navgrid);

global.room_loaded = false;