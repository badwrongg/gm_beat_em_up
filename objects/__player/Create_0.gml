team = e_team.player;

event_inherited();

input_x = 0;
input_y = 0;

input_attack  = 0;
input_special = 0;
input_jump    = 0;

// TODO add input bind system, this is temporary
input_bind_attack  = ord("J");
input_bind_special = ord("K");
input_bind_jump    = vk_space;