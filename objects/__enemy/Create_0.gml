team = e_team.enemy;

event_inherited();

game_speeds = get_game_speeds();

ai_target = noone;
ai_target_x = 0;
ai_target_y = 0;
ai_target_dir = 0;
ai_target_dist = infinity;
ai_target_object = __player;

ai_path = path_add();
ai_target_update_timer = random(2);

attack_range = (bbox_right - bbox_left) * 0.6;