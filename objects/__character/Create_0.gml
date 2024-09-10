event_inherited();
event_user(EV_ANIMATION_SPRITES);
event_user(EV_ACTION_STATES);
event_user(EV_ATTACK_DATA);
event_user(EV_METHOD_BINDS);

// General
input_x				= 0;
input_y				= 0;
x_draw				= 0;
y_draw				= 0;
has_armor		    = false;
has_local_avoidance = true;
hurtbox				= hurtbox_create(x, y, id, sprite_index);
hitpoints_max       = hitpoints;
hit_depth			= C_CHARACTER_HIT_DEPTH;
safe_nav_x			= x;
safe_nav_y			= y;
ai_navgrid			= global.navgrid;
bbox_width          = bbox_right - bbox_left;
bbox_height         = bbox_bottom - bbox_top;

// State
action_state     = action_state_free;
action_animation = false;
can_move         = true;
can_impulse      = true;
can_act			 = true;

// Attack
attack_active   = C_CHARACTER_NO_ATTACK;
hit_list = ds_list_create();
tag_list = ds_list_create();

// Movement
collided_object = __collider_all;
collided_count  = 0;
collided_with   = noone;

move_x         = 0;
move_y         = 0;
move_dir       = 0;
move_speed     = 0;
move_norm_x    = 0;
move_norm_y    = 0;
move_speed_mod = 1;
move_friction  = 1;

impulse_force_x  = 0;
impulse_force_y  = 0;
impulse_force_z  = 0;
impulse_friction = C_MOVE_IMPULSE_FRICTION;
impulse_mod      = 1;

constant_force_x = 0;
constant_force_y = 0;

velocity_x = 0;
velocity_y = 0;
velocity   = 0;

on_ground	   = true;
avoid_x		   = 0;
avoid_y		   = 0;
avoid_radius_x = bbox_width * 0.5;
avoid_radius_y = bbox_height * 0.5;