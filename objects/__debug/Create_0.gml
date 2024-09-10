#macro DEBUG_TEXT var _scale = get_gui_dimensions()[e_gui_dimension.scale], _textH = string_height("H") * _scale;
#macro TX var _textX = 
#macro TY var _textY = 
#macro TEXT draw_text_transformed(_textX, _textY,
#macro ENDLINE , _scale, _scale, 0); _textY += _textH
#macro NEWLINE _textY += _textH
#macro NEWLINEx _textY += _textH * 

debug_on = true;
draw_navgrid = false;
draw_overlay = true;
draw_collision = false;
draw_combat = false;

team = e_team.player;

show_debug_overlay(draw_overlay);	

controls =
@"
ESC: Exit
F10: Reset Room

F1: Toggle Debug
F2: Toggle Collisions
F3: Toggle Combat
F4: Toggle Navgrid

WASD:  Move
Space: Jump
J key: Attack
";