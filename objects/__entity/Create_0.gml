event_inherited();

// An entity is an object which exists in the game world, execute code, and is visible

event_tick  = method(id, event_tick);
game_speeds = get_game_speeds();
anim_speed  = 1;	 // Actual animation speed since pausing will set image_speed to 0