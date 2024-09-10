load_step = -1;

get_game_camera(0).set_position(x, y);

var _col = room_width div C_NAVGRID_CELL_WIDTH,
	_row = room_height div C_NAVGRID_CELL_HEIGHT;
	
global.navgrid = mp_grid_create(0, 0, _col, _row, C_NAVGRID_CELL_WIDTH, C_NAVGRID_CELL_HEIGHT); 