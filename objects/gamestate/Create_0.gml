event_user(EV_FUNCTION_DECLARATIONS); // Declare gamestate functions

game_state   = gs_none;
game_paused  = true;
game_cam0    = get_game_camera(0);
entity_list  = ds_list_create();
entity_count = 0;
frame_speed  = 1;
anim_speed   = 1;
particle_systems = get_particle_systems();

global.room_loaded = false;
