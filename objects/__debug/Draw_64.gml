if (!debug_on)
	exit;

draw_set_font(fnt_debug);
draw_set_valign(fa_top);
draw_set_halign(fa_left);

DEBUG_TEXT;
TX 40;
TY 600;

TEXT "- beat 'em up -" ENDLINE;
TEXT "fps: " + string(fps) ENDLINE;

with (entity_player)
{
	TEXT "speed: " + string(move_speed) ENDLINE;
	TEXT "x: " + string(x) ENDLINE;
	TEXT "y: " + string(y) ENDLINE;
	TEXT "z: " + string(impulse_force_z) ENDLINE;
	TEXT "nx: " + string(avoid_x) ENDLINE;
}

TEXT controls ENDLINE;

NEWLINE;